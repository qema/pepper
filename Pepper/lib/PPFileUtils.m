//
//  PPFileUtils.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPFileUtils.h"

@implementation PPFileUtils

+(NSString *)fullPath:(NSString *)filename
{
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    return path;
}
@end
