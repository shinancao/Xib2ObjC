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
        case NSStreamEventOpenCompleted:
            NSLog(@"客户端输入输出流打开完成");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"客户端有字节可读");
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"客户端可以发送字节");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"客户端连接出现错误");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"客户端连接结束");
            [_inputStream close];
            [_outputStream close];
            
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            break;
        default:
            break;
    }
}

- (void)readData {
    uint8_t buf[1024];
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    NSData *data = [NSData dataWithBytes:buf length:len];
    NSString *recivedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Socket:读取从服务端发来的消息:%@",recivedString);
}

- (void)connectServer {
    NSString *host = @"192.168.1.103";
    int port = 8585;
    
    CFReadStreamRef readStreamRef;
    CFWriteStreamRef writeStreamRef;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStreamRef, &writeStreamRef);
    _inputStream = (__bridge NSInputStream *)(readStreamRef);
    _outputStream = (__bridge NSOutputStream *)(writeStreamRef);
    
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    [_inputStream open];
    [_outputStream open];
    
}

- (instancetype)init {
    if (self = [super init]) {
        [self connectServer];
    }
    return self;
}

@end
