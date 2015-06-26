//
//  L8NewsCell.h
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const CGFloat L8NewsCellPadding;
FOUNDATION_EXPORT const CGFloat L8NewsCellTitleFontSize;
FOUNDATION_EXPORT const CGFloat L8NewsCellSummaryFontSize;
FOUNDATION_EXPORT const CGFloat L8NewsCellWebsiteFontSize;
FOUNDATION_EXPORT const CGFloat L8NewsCellTimeFontSize;
FOUNDATION_EXPORT const CGFloat L8NewsCellImageHeight;
FOUNDATION_EXPORT const CGFloat L8NewsCellImageWidth;

@class L8News;
@interface L8NewsCell : UITableViewCell

@property (weak, nonatomic) UILabel *title;
@property (weak, nonatomic) UILabel *summary;
@property (weak, nonatomic) UILabel *website;
@property (weak, nonatomic) UILabel *time;
@property (weak, nonatomic) UIImageView *image;

@property (strong, nonatomic) L8News *news;

+(CGFloat)miniHeightWithImage:(BOOL)withImage;
@end
