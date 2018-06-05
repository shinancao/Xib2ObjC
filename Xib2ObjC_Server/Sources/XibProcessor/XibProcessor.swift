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
    }
    
    // MARK: - Private Methods
    private func getDictionaryFromXib() {
        let fileMgr = FileManager.default
        
        if fileMgr.fileExists(atPath: xmlTmpPath) {
            try? fileMgr.removeItem(atPath: xmlTmpPath)
        }
        
        let p = Process()
        p.launchPath = "/usr/bin/env"
        p.arguments = ["ibtool", _filename, "--write", xmlTmpPath]; //"--objects", "--hierarchy"
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
    
    private func enumerate(_ indexer: XMLIndexer) {
        let identifier = indexer.element!.attribute(by: "id")!.text.replacingOccurrences(of: "-", with: "").lowercased()
        
        let processor = Processor.processor(elementName: indexer.element!.name)
        if let processor = processor {
            let obj = processor.process(indexer: indexer)
            _objects[identifier] = obj
        }
        
        let subviewsIndexer = indexer["subviews"]
        if (subviewsIndexer.element != nil) {
            let subviews = subviewsIndexer.children
            subviews.forEach{indexer in enumerate(indexer)}
        }
        
        print("_objects: \(_objects)")
    }
    
    // MARK: - Public Methods
    public func process() {
        guard let xml = _xml else {
            return
        }
        
        let root = xml["document"]["objects"]["view"]
        enumerate(root)
    }
    
    public func inputAsDictionary() -> [String: Any] {
        let propertyList = try! PropertyListSerialization.propertyList(from: _data, options: [], format: nil) as! [String: Any]
        return propertyList
    }
    
    public func inputAsText() -> String {
        return String(data: _data, encoding: String.Encoding.utf8)!
    }
}
