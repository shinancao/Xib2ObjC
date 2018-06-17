//
//  XibProcessor.swift
//  Xib2ObjC_Server
//
//  Created by 张楠[产品技术中心] on 2018/5/28.
//

import Foundation
import SWXMLHash

public class XibProcessor: NSObject {
    private var _xml: XMLIndexer?
    private var _data: Data
    private var _filename: String
    private var _output: String
    private var _objects: [String: [String: String]]
    private var _hierarchys: [String: [String]]
    private lazy var xmlTmpPath: String = {
        let path = Bundle.main.bundlePath
        return path + "/tmpXML"
    }()
    
    public var input: String {
        get {
            return _filename
        }
        set(newValue) {
            _filename = newValue
            getDictionaryFromXib()
        }
    }
    public var output: String {
        get {
            return _output
        }
    }
    
    override public init() {
        _data = Data()
        _filename = ""
        _output = ""
        _objects = [String: [String: String]]()
        _hierarchys = [String: [String]]()
    }
    
    // MARK: - Private Methods
    private func getDictionaryFromXib() {
        let fileMgr = FileManager.default
        
        if !fileMgr.fileExists(atPath: _filename) {
            print("xib file doesn't exist.")
            return
        }
        
        if fileMgr.fileExists(atPath: xmlTmpPath) {
            try? fileMgr.removeItem(atPath: xmlTmpPath)
        }
        
        let p = Process()
        p.launchPath = "/usr/bin/env"
        p.arguments = ["ibtool", _filename, "--write", xmlTmpPath];
        p.launch()
        p.waitUntilExit()
        
        if !p.isRunning {
            let status = p.terminationStatus
            if status == 0 {
                // task succeeded.
                if fileMgr.fileExists(atPath: xmlTmpPath) {
                    _data = fileMgr.contents(atPath: xmlTmpPath)!
                    let text = inputAsText()
                    _xml = SWXMLHash.parse(text)
                }
            } else {
                // task failed.
            }
        }
    }
    
    private func enumerate(_ indexer: XMLIndexer, level: Int) {
        
        let processor = Processor.processor(elementName: indexer.element!.name)
        guard let p = processor else {
            print("unknown xib object.")
            return
        }
        
        var obj = p.process(indexer: indexer)
        if level == 0 {
            obj["instanceName"] = "self"
        }
        let identifier = indexer.element!.idString
        _objects[identifier] = obj
        
        var subObjs = [String]()
        let subviewsIndexer = indexer["subviews"]
        if (subviewsIndexer.element != nil) {
            let subviews = subviewsIndexer.children
            subviews.forEach({ (indexer) in
                subObjs.append(indexer.element!.idString)
                enumerate(indexer, level: level+1)
            })
        }
        
        if subObjs.count > 0 {
            _hierarchys[identifier] = subObjs
        }
    }
    
    // MARK: - Public Methods
    public func process() {
        guard let xml = _xml else {
            return
        }
        
        // get all objects
        let root = xml["document"]["objects"]["view"]
        enumerate(root, level: 0)
        
        //construct output string
        for (_, object) in _objects.reversed() {
            
            let instanceName = object["instanceName"]!
            
            let klass = object["class"]!
            let constructor = object["constructor"]!
            if instanceName != "self" {
                _output.append("\(klass) *\(instanceName) = \(constructor);\n")
            }
            
            object.sorted(by: {$0.0 < $1.0}).filter{(key, _) in !["instanceName", "class", "constructor"].contains(key) && !key.hasPrefix("__method__") }.forEach({ (key, value) in
                _output.append("\(instanceName).\(key) = \(value);\n")
            })
            
            object.sorted(by: {$0.0 < $1.0}).filter{(key, _) in key.hasPrefix("__method__")}.forEach({ (_, value) in
                _output.append("[\(instanceName) \(value)];\n")
            })
            
            _output.append("\n")
        }
        
        _hierarchys.forEach { (superviewId, subviewsId) in
            let superInstanceName = _objects[superviewId]!["instanceName"]!
            subviewsId.forEach({ (subviewId) in
                let subInstanceName = _objects[subviewId]!["instanceName"]!
                _output.append("[\(superInstanceName) addSubview:\(subInstanceName)];\n")
            })
        }
        
        print(_output)
    }
    
    public func inputAsText() -> String {
        return String(data: _data, encoding: String.Encoding.utf8)!
    }
}
