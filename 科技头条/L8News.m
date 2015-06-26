//
//  L8News.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8News.h"

@implementation L8News

+(instancetype)newsWithDict:(NSDictionary *)dict
{
    L8News *new = [[self alloc] init];
    
    for (NSString *key in [self properties]) {
        [new setValue:dict[key] forKey:key];
    }
    
    return new;
}

+(NSArray *)properties
{
    return @[@"title",@"summary",@"sitename",@"addtime",@"img"];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"img:%@",self.img];
}

@end
