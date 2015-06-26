//
//  L8DateExt.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8DateExt.h"

@implementation L8DateExt

+(NSString *)stringWithSecs:(double)secs
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    return [formatter stringFromDate:date];
}

@end
