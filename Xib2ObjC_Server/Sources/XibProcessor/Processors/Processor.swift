//
//  Processor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation

class Processor: NSObject {
    var input = [String: Any]() //存储该processor从xib读取到的[key:value]
    var output = [String: Any]() //存储根据input构造的输出字符串
    
    func process(key: String, value: Any) {}
    func getProcessedClassName() -> String { return "" }
    func constructorString() -> String {
        return "[[\(getProcessedClassName()) alloc] init]"
    }
}

extension Processor {
    class func processor(for klass: String) -> Processor? {
        var processor: Processor? = nil
        if klass == "IBUIView" {
            processor = UIViewProcessor()
        } else if klass == "IBUILabel" {
            processor = UILabelProcessor()
        } else if klass == "IBUIButton" {
            processor = UIButtonProcessor()
        } else if klass == "IBUIImageView" {
            processor = UIImageViewProcessor()
        }
        
        return processor
    }
    
    func process(object: [String: Any]) -> [String: Any] {
        input = object
        output.removeAll()
        
        for (key, value) in input {
            process(key: key, value: value)
        }
        
        output["constructor"] = constructorString()
        
        return output
    }
}


