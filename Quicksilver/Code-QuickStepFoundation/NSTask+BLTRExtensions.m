//
// NSTask+BLTRExtensions.m
// Quicksilver
//
// Created by Alcor on 2/7/05.
// Copyright 2005 Blacktree. All rights reserved.
//

#import "NSTask+BLTRExtensions.h"


@implementation NSTask (BLTRExtensions)

+ (NSTask *)taskWithLaunchPath:(NSString *)path arguments:(NSArray *)arguments {
    return [NSTask taskWithLaunchPath:path arguments:arguments input:nil];
}

+ (NSTask *)taskWithLaunchPath:(NSString *)path arguments:(NSArray *)arguments input:(NSData *)inputData {
    NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:path];
	[task setArguments:arguments];
    if (inputData) {
        NSPipe *inputPipe = [NSPipe pipe];
        NSFileHandle *inputHandle = [inputPipe fileHandleForWriting];
        [task setStandardInput:inputPipe];
        [inputHandle writeData:inputData];
    }
	return task;
}

- (NSData *)launchAndReturnOutput {
	[self setStandardOutput:[NSPipe pipe]];
	[self launch];
	[self waitUntilExit];
	return [[[self standardOutput] fileHandleForReading] readDataToEndOfFile];
}

@end
