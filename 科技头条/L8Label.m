//
//  L8Label.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8Label.h"


@implementation L8Label

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init {
    self = [super init];
    
    // required to prevent Auto Layout from compressing the label (by 1 point usually) for certain constraint solutions
//    [self setContentCompressionResistancePriority:UILayoutPriorityRequired
//                                          forAxis:UILayoutConstraintAxisVertical];
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.preferredMaxLayoutWidth = self.bounds.size.width;
    
    [super layoutSubviews];
}

-(NSString *)description
{
    return self.text;
}

@end
