//
//  StreamHelper.m
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/5/19.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import "StreamHelper.h"

@interface StreamHelper()<NSStreamDelegate>

@end

@implementation StreamHelper {
    NSInputStream  *_inputStream;
    NSOutputStream *_outputStream;
}

- (void)sendMsg:(NSString *)message {
    NSData *msgData = [message dataUsingEncoding:NSUTF8StringEncoding];
    [_outputStream write:msgData.bytes maxLength:msgData.length];
}

#pragma mark - NSStreamDelegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:
            if (aStream == _inputStream) {
                [self readData];
            }
            break;
        default:
            break;
    }
}

- (void)readData {
    uint8_t buf[1024];
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    NSData *data = [NSData dataWithBytes:buf length:len];
    NSString *receivedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Client received:%@",receivedString);
}

- (void)open {
    NSString *host = @"::1";
    int port = 8585;
    
    CFReadStreamRef readStreamRef;
    CFWriteStreamRef writeStreamRef;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStreamRef, &writeStreamRef);
    _inputStream = (__bridge NSInputStream *)(readStreamRef);
    _outputStream = (__bridge NSOutputStream *)(writeStreamRef);
    
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [_inputStream open];
    [_outputStream open];
    
}

- (void)close {
    [_inputStream close];
    [_outputStream close];
    
    [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    _inputStream.delegate = nil;
    _outputStream.delegate = nil;
    
    _inputStream = nil;
    _outputStream = nil;
}

@end
