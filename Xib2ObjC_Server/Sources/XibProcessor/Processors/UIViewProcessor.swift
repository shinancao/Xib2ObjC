//
//  UIViewProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation

class UIViewProcessor: Processor {
    override func getProcessedClassName() -> String {
        return "UIView"
    }
    
    override func constructorString() -> String {
        return "[[\(getProcessedClassName()) alloc] initWithFrame:CGRect]"
    }
    
    override func process(key: String, value: Any) {
        // Subclasses can override this method for their own properties.
        // In those cases, call ;
        // to be sure that mother classes do their work too.
        
        
    }
}
