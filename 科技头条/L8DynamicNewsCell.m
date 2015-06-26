//
//  L8DynamicNewsCell.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8DynamicNewsCell.h"
#import "L8News.h"
#import "UIImageView+WebCache.h"
#import "L8DateExt.h"

@interface L8DynamicNewsCell ()
@property (strong, nonatomic) NSMutableArray *mutableConstraint;
@property (strong, nonatomic) NSMutableArray *imageConstraint;

@end

@implementation L8DynamicNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.title.translatesAutoresizingMaskIntoConstraints = NO;
        self.summary.translatesAutoresizingMaskIntoConstraints = NO;
        self.website.translatesAutoresizingMaskIntoConstraints = NO;
        self.time.translatesAutoresizingMaskIntoConstraints = NO;
        self.image.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.mutableConstraint = [NSMutableArray array];
        self.imageConstraint = [NSMutableArray array];
        [self makeConstraint];
    }
    
    return self;
}

-(CGFloat)rightGutterWidth
{
    if (![self.news.img isEqualToString:@""]) {
        return L8NewsCellImageWidth + L8NewsCellPadding*2;
    }
    return L8NewsCellPadding;
}

-(void)setNews:(L8News *)news
{    
    [super setNews:news];
    
    if (![news.img isEqualToString:@""]) {
        self.image.hidden = NO;
    }else
    {
        self.image.hidden = YES;
    }
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    for (NSLayoutConstraint *constraint in self.mutableConstraint) {
        constraint.constant = [self rightGutterWidth];
    }
    
    if (![self.news.img isEqualToString:@""]) {
        [self.contentView addConstraints:self.imageConstraint];
    }else
    {
        [self.contentView removeConstraints:self.imageConstraint];
    }
}

-(void)makeConstraint
{
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.mutableConstraint removeAllObjects];
    [self.imageConstraint removeAllObjects];
    
    //title constraint
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:L8NewsCellPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:L8NewsCellPadding]];
    
    //summary constraint
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.summary attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:L8NewsCellPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.summary attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title attribute:NSLayoutAttributeBottom multiplier:1 constant:L8NewsCellPadding]];
    
    //website constraint
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.website attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:L8NewsCellPadding]];
    
    NSLayoutConstraint *maringBetweenSummaryWebsite = [NSLayoutConstraint constraintWithItem:self.website attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.summary attribute:NSLayoutAttributeBottom multiplier:1 constant:L8NewsCellPadding];
    maringBetweenSummaryWebsite.priority = 999;
    [self.contentView addConstraint:maringBetweenSummaryWebsite];
    
    NSLayoutConstraint *summaryBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.website attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    summaryBottom.priority = UILayoutPriorityRequired;
    [self.contentView addConstraint:summaryBottom];
    
    //time constraint
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.time attribute:NSLayoutAttributeRight multiplier:1 constant:L8NewsCellPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.time attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
 
    //mutable constraint
    NSLayoutConstraint *titleRightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.title attribute:NSLayoutAttributeRight multiplier:1 constant:[self rightGutterWidth]];
    titleRightConstraint.priority = 999;
    NSLayoutConstraint *summaryRightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.summary attribute:NSLayoutAttributeRight multiplier:1 constant:[self rightGutterWidth]];
    summaryRightConstraint.priority = 999;
    [self.mutableConstraint addObject:titleRightConstraint];
    [self.mutableConstraint addObject:summaryRightConstraint];
    [self.contentView addConstraints:self.mutableConstraint];

    //image constraint
    //NSLayoutConstraint *imageRightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.image attribute:NSLayoutAttributeRight multiplier:1 constant:L8NewsCellPadding];
    NSLayoutConstraint *imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.image attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:L8NewsCellPadding];
    NSLayoutConstraint *imageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.image attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.title attribute:NSLayoutAttributeRight multiplier:1 constant:L8NewsCellPadding];
    NSLayoutConstraint *imageBottomConstraint = [NSLayoutConstraint constraintWithItem:self.summary attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.image attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    //imageBottomConstraint.priority = 999;
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.image attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:L8NewsCellImageWidth];
//    imageWidthConstraint.priority = 999;
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.image attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:L8NewsCellImageHeight];
//    imageHeightConstraint.priority = 999;
    //[self.imageConstraint addObject:imageRightConstraint];
    [self.imageConstraint addObject:imageLeftConstraint];
    [self.imageConstraint addObject:imageTopConstraint];
    [self.imageConstraint addObject:imageBottomConstraint];
    [self.imageConstraint addObject:imageWidthConstraint];
    [self.imageConstraint addObject:imageHeightConstraint];
 
}


@end
