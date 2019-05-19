//
//  XibFileHelper.m
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/4/21.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import "XibFileHelper.h"

@interface XibFileHelper()
@property (nonatomic, strong) NSArray *xibFileNames;
@end
@implementation XibFileHelper

- (instancetype)init {
    if (self = [super init]) {
        _xibFileNames = [self getAllXibNames];
    }
    return self;
}

- (NSArray *)getAllXibNames {
    NSMutableArray *xibNames = @[].mutableCopy;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSArray *dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    [dirs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"nib"]) {
            [xibNames addObject:[filename stringByDeletingPathExtension]];
        }
    }];
    
    return xibNames;
}


@end
