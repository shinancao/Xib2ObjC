//
//  XibProcessor.m
//  Xib2ObjC
//
//  Created by 张楠[产品技术中心] on 2018/5/24.
//  Copyright © 2018年 zhangnan. All rights reserved.
//

#import "XibProcessor.h"

@interface XibProcessor()
{
    NSString *_fileName;
    NSDictionary *_dictionary;
    NSMutableData *_data;
}
@end

@implementation XibProcessor

@dynamic input;

#pragma mark - Properties

- (NSString *)input {
    return _fileName;
}

- (void)setInput:(NSString *)newFileName {
    _fileName = [newFileName copy];
    [self getDictionaryFromXIB];
}

#pragma mark - Private Metheds
- (void)getDictionaryFromXIB {
    
}

@end
