//
//  L8Controller.m
//  科技头条
//
//  Created by 李亮 on 15/6/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8Controller.h"
#import "L8News.h"
#import "L8DynamicNewsCell.h"
#import "L8ManualNewsCell.h"

#define REUSE_ID_AUTOLAYOUT @"autolayoutcell"
#define REUSE_ID_MANUALLAYOUT @"manuallayoutcell"

@interface L8Controller ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) NSMutableArray *news;
@property (strong, nonatomic) L8DynamicNewsCell *prototypeCell;
@end

@implementation L8Controller

- (IBAction)layoutChanged:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[L8DynamicNewsCell class] forCellReuseIdentifier:REUSE_ID_AUTOLAYOUT];
    [self.tableView registerClass:[L8ManualNewsCell class] forCellReuseIdentifier:REUSE_ID_MANUALLAYOUT];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:REUSE_ID_AUTOLAYOUT];
    self.prototypeCell.autoresizingMask = UIViewAutoresizingFlexibleWidth; // this must be set for the cell heights to be calculated correctly in landscape
    self.prototypeCell.hidden = YES;
    
    [self.tableView addSubview:self.prototypeCell];

    self.prototypeCell.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 0);
    
    self.segment.selectedSegmentIndex = 1;
    
    [self loadNews];
}


-(NSMutableArray *)news
{
    if (!_news) {
        _news = [NSMutableArray array];
    }
    return _news;
}

-(void)loadNews
{
    NSURL *url = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1433735258/type/0?channel=appstore&uuid=64543C0F-89E1-4D63-B947-DB4C504D13B1&net=5&model=iPhone&ver=1.0.5"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError && data) {
            NSArray *newsInJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            for (NSDictionary *dict in newsInJson) {
                L8News *news = [L8News newsWithDict:dict];
                [self.news addObject:news];
            }
            [self.tableView reloadData];
        }else
        {
            NSLog(@"get data failed.");
        }

    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    L8NewsCell *cell;
    if (self.segment.selectedSegmentIndex == 0) {
       cell = [self.tableView dequeueReusableCellWithIdentifier:REUSE_ID_AUTOLAYOUT forIndexPath:indexPath];

    }else
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:REUSE_ID_MANUALLAYOUT];
    }

    L8News *news = self.news[indexPath.row];
    cell.news = news;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回UITableViewAutomaticDimension不能提高性能
    //return UITableViewAutomaticDimension;
    return [L8NewsCell miniHeightWithImage:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static int i = 0;
    NSLog(@"height:%d",i++);
    if (self.segment.selectedSegmentIndex == 0) {
        self.prototypeCell.news = self.news[indexPath.row];
        [self.prototypeCell updateConstraintsIfNeeded];
        [self.prototypeCell layoutIfNeeded];
        
        CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return 1+ size.height;
    }else
    {
        return [L8ManualNewsCell heightForNews:self.news[indexPath.row] withConstraintWidth:tableView.bounds.size.width];
    }

}


@end
