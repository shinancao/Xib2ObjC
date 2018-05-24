//
//  XibProcessor.h
//  Xib2ObjC
//
//  Created by 张楠[产品技术中心] on 2018/5/24.
//  Copyright © 2018年 zhangnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XibProcessor : NSObject

@property (nonatomic, copy) NSString *input;
@property (nonatomic, copy, readonly) NSString *output;


@end
