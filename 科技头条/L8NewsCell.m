//
//  L8NewsCell.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8NewsCell.h"
#import "L8Label.h"
#import "L8News.h"
#import "UIImageView+WebCache.h"
#import "L8DateExt.h"

const CGFloat L8NewsCellPadding = 10.0;
const CGFloat L8NewsCellTitleFontSize = 16;
const CGFloat L8NewsCellSummaryFontSize = 12;
const CGFloat L8NewsCellWebsiteFontSize = 10;
const CGFloat L8NewsCellTimeFontSize = 10;
const CGFloat L8NewsCellImageHeight = 100;
const CGFloat L8NewsCellImageWidth = 100;

@interface L8NewsCell ()


@end

@implementation L8NewsCell

+(CGFloat)miniHeightWithImage:(BOOL)withImage
{
    if (withImage) {
        return L8NewsCellImageHeight + L8NewsCellPadding*3 +
            [@"L8" boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:L8NewsCellTimeFontSize]} context:NULL].size.height;
    }else
    {
        return 100;
    }
}

-(void)setNews:(L8News *)news
{
    _news = news;
    
    self.title.text = news.title;
    self.summary.text = news.summary;
    self.website.text = news.sitename;
    [self.image sd_setImageWithURL:[NSURL URLWithString:news.img]];
    self.time.text = [L8DateExt stringWithSecs:news.addtime];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *title = [[L8Label alloc] init];
        self.title = title;
        [title setFont:[UIFont boldSystemFontOfSize:L8NewsCellTitleFontSize]];
        [title setTextColor:[UIColor blackColor]];
        title.numberOfLines = 0;
        title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:title];
        
        
        UILabel *summary = [[L8Label alloc] init];
        self.summary = summary;
        [summary setFont:[UIFont systemFontOfSize:L8NewsCellSummaryFontSize]];
        [summary setTextColor:[UIColor blackColor]];
        summary.numberOfLines = 0;
        summary.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:summary];
        
        UILabel *website = [[L8Label alloc] init];
        self.website = website;
        [website setFont:[UIFont systemFontOfSize:L8NewsCellWebsiteFontSize]];
        [website setTextColor:[UIColor grayColor]];
        website.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:website];
        //website.backgroundColor = [UIColor redColor];
        
        UILabel *time = [[L8Label alloc] init];
        self.time = time;
        [time setFont:[UIFont systemFontOfSize:L8NewsCellTimeFontSize]];
        [time setTextColor:[UIColor grayColor]];
        time.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:time];
        //time.backgroundColor = [UIColor redColor];
        
        UIImageView *image = [[UIImageView alloc] init];
        self.image = image;
        [self.contentView addSubview:image];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
