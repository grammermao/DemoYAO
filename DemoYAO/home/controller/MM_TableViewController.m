//
//  MM_TableViewController.m
//  DemoYAO
//
//  Created by yuchen_Mac on 2018/2/27.
//  Copyright © 2018年 yuchen_Mac. All rights reserved.
//

#import "MM_TableViewController.h"
#import "MM_ListTableViewCell.h"
#import "MM_ListModel.h"

@interface MM_TableViewController ()
@property(nonatomic ,strong) NSDictionary *data;
@property(nonatomic ,strong) NSMutableArray *dataArr;
@property(nonatomic ,strong) NSOperationQueue *queue;

@end

@implementation MM_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.estimatedRowHeight = 116.5f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadData];
}

/**
 请求数据
 */
-(void)loadData{
    [PPNetworkHelper GET:@"/facts.json" parameters:nil success:^(id responseObject) {
        [self setTitle:responseObject[@"title"]];
        [self addData:responseObject[@"rows"]];
    } failure:^(NSError *error) {

    }];
}

-(void)addData:(NSArray *)data{
    for (int i = 0; i<data.count; i++) {
        MM_ListModel *model = [[MM_ListModel alloc]initWithDictionry:data[i]];
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MM_ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    MM_ListModel *model = self.dataArr[indexPath.row];
    cell.title.text = model.title;
    cell.titleDesc.text = model.desc;
    
    
    ///图片懒加载方法一：用SDWebImage（有点大材小用）我也常用的是SD
//    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageHref]];
    
    ///方法二：自己写多线程
    //    [self imageWithUrl:model.imageHref indexpath:indexPath];
//        [self.queue addOperationWithBlock: ^{
//            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageHref]]; //得到图像数据
//            UIImage *image = [UIImage imageWithData:imgData];
//            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
//                cell.imageV.image = image;
//                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            }];
//        }];
    return cell;
}


/**
 lazy

 @return <#return value description#>
 */
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (NSOperationQueue *)queue {
    if (!_queue) _queue = [[NSOperationQueue alloc] init];
    return _queue;
}
@end
