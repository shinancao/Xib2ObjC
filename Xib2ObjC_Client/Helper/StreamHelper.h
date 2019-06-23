//
//  StreamHelper.h
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/5/19.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StreamHelper : NSObject

- (void)sendMsg:(NSString *)message;
- (void)open;
- (void)close;

@end

NS_ASSUME_NONNULL_END
