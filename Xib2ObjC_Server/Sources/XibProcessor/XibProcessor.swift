//
//  XibProcessor.swift
//  Xib2ObjC_Server
//
//  Created by 张楠[产品技术中心] on 2018/5/28.
//

import Foundation

public class XibProcessor: NSObject {
    private var _dictionary: [String: Any]
    private var _data: Data
    private var _filename: String
    private var _output: String
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
        _dictionary = [String: Any]()
        _data = Data()
        _filename = ""
        _output = ""
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
                    print(text)
                }
            } else {
                // task failed.
            }
        }
    }
    
    // MARK: - Public Methods
    public func process() {
//        let xibObjects = _dictionary["com.apple.ibtool.document.objects"] as! [String: Any]
//        for (key, value) in xibObjects {
//            print("key: "+key)
//        }
        
    }
    
    public func inputAsDictionary() -> [String: Any] {
        let propertyList = try! PropertyListSerialization.propertyList(from: _data, options: [], format: nil) as! [String: Any]
        return propertyList
    }
    
    public func inputAsText() -> String {
        return String(data: _data, encoding: String.Encoding.utf8)!
    }
}
