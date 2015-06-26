//
//  L8News.h
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8News : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *sitename;
@property (assign, nonatomic) double addtime;
@property (copy, nonatomic) NSString *img;

+(instancetype)newsWithDict:(NSDictionary *)dict;

@end
