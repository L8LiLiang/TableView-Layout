//
//  L8ManualNewsCell.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8ManualNewsCell.h"
#import "L8News.h"

@implementation L8ManualNewsCell

-(void)setNews:(L8News *)news
{
    [super setNews:news];
    
    [self setNeedsLayout];
}

+(CGFloat)heightForNews:(L8News*)news withConstraintWidth:(CGFloat)width
{
    if ([news.img isEqualToString:@""]) {
        CGFloat constraintWidth = width - L8NewsCellPadding*2;
        return L8NewsCellPadding +
                [self heightForTitleWithNews:news withConstraintWidth:constraintWidth] +
                L8NewsCellPadding +
                [self heightForSummaryWithNews:news withConstraintWidth:constraintWidth] +
                L8NewsCellPadding +
                [self heightForSitenameWithNews:news withConstraintWidth:(constraintWidth - L8NewsCellPadding*3) * 0.5];
        
    }else
    {
        CGFloat textLabelWidth = width - L8NewsCellImageWidth - L8NewsCellPadding * 3;
        CGFloat sitenameWidth = (width - L8NewsCellPadding * 3) * 0.5;
        //CGFloat timeWidth = sitenameWidth;
        
        CGFloat height1 =
            L8NewsCellPadding +
            [self heightForTitleWithNews:news withConstraintWidth:textLabelWidth] +
            L8NewsCellPadding +
            [self heightForSummaryWithNews:news withConstraintWidth:textLabelWidth] +
            L8NewsCellPadding +
            [self heightForSitenameWithNews:news withConstraintWidth:sitenameWidth];
        
        CGFloat height2 =
            L8NewsCellPadding +
            L8NewsCellImageHeight +
            L8NewsCellPadding +
            [self heightForTimeWithNews:news withConstraintWidth:width];
        
        return MAX(height1, height2);
    }
}

+(CGFloat)heightForTitleWithNews:(L8News*)news withConstraintWidth:(CGFloat)width
{
    CGSize size = [news.title boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:L8NewsCellTitleFontSize]} context:nil].size;
    return size.height;
}

+(CGFloat)heightForSummaryWithNews:(L8News*)news withConstraintWidth:(CGFloat)width
{
    CGSize size = [news.summary boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:L8NewsCellSummaryFontSize]} context:nil].size;
    return size.height;
}

+(CGFloat)heightForSitenameWithNews:(L8News*)news withConstraintWidth:(CGFloat)width
{
    CGSize size = [news.sitename boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:L8NewsCellWebsiteFontSize]} context:nil].size;
    return size.height;
}

+(CGFloat)heightForTimeWithNews:(L8News*)news withConstraintWidth:(CGFloat)width
{
    CGSize size = [@"2015-06-09" boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:L8NewsCellTimeFontSize]} context:nil].size;
    return size.height;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
  
    CGFloat titleX = L8NewsCellPadding;
    CGFloat titleY = L8NewsCellPadding;
    CGFloat titleW = self.bounds.size.width - L8NewsCellPadding * 2;
    if (![self.news.img isEqualToString:@""]) {
        titleW -= L8NewsCellPadding + L8NewsCellImageWidth;
    }
    CGFloat titleH = [L8ManualNewsCell heightForTitleWithNews:self.news withConstraintWidth:titleW];
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat summaryX = L8NewsCellPadding;
    CGFloat summaryY = L8NewsCellPadding + CGRectGetMaxY(self.title.frame);
    CGFloat summaryW = self.bounds.size.width - L8NewsCellPadding * 2;
    if (![self.news.img isEqualToString:@""]) {
        summaryW -= L8NewsCellPadding + L8NewsCellImageWidth;
    }        CGFloat summaryH = [L8ManualNewsCell heightForSummaryWithNews:self.news withConstraintWidth:summaryW];
    self.summary.frame = CGRectMake(summaryX, summaryY, summaryW, summaryH);
    
    
    CGFloat websiteX = L8NewsCellPadding;
    CGFloat websiteW = (self.bounds.size.width - L8NewsCellPadding * 3) * 0.5;
    CGFloat websiteH = [L8ManualNewsCell heightForSitenameWithNews:self.news withConstraintWidth:websiteW];
    CGFloat websiteY = self.bounds.size.height - websiteH;
    self.website.frame = CGRectMake(websiteX, websiteY, websiteW, websiteH);
    
    CGFloat timeX = L8NewsCellPadding + CGRectGetMaxX(self.website.frame);
    CGFloat timeW = websiteW;
    CGFloat timeH = [L8ManualNewsCell heightForTimeWithNews:self.news withConstraintWidth:timeW];
    CGFloat timeY = self.bounds.size.height - timeH;
    self.time.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    if (![self.news.img isEqualToString:@""]) {
        CGFloat imageX = CGRectGetMaxX(self.title.frame) + L8NewsCellPadding;
        CGFloat imageY = L8NewsCellPadding;
        self.image.frame = CGRectMake(imageX, imageY, L8NewsCellImageWidth, L8NewsCellImageHeight);
    }
    
}


@end
