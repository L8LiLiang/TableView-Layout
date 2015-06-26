//
//  L8ManualNewsCell.h
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8NewsCell.h"

@interface L8ManualNewsCell : L8NewsCell
+(CGFloat)heightForNews:(L8News*)news withConstraintWidth:(CGFloat)width;
@end
