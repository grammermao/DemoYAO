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
@property(nonatomic,strong) NSMutableArray *heightArr;
@property(nonatomic ,strong) NSOperationQueue *queue;

@end

@implementation MM_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"MM_ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
//    self.tableView.estimatedRowHeight = 200.0f;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
    [self setupHeight];
}
-(void)setupHeight{
    self.heightArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<self.dataArr.count; i++) {
        MM_ListModel *model = self.dataArr[i];;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageHref]];
            CGSize imageSize=[UIImage imageWithData:data].size;
            CGFloat scanl =  imageSize.width/80.0;
            if (scanl != 0) {
                CGFloat height = imageSize.height /scanl;
                height += 22;
                CGFloat height_desctext = [self heightForText:model.desc FontSize:14].size.height;
                CGFloat height_titletext = [self heightForText:model.title FontSize:16].size.height;
                CGFloat height_text = height_desctext+height_titletext+30;
                if (height>height_text) {
                    model.height = height;
                }else{
                    model.height = height_text;
                }

            }else{
                CGFloat height_desctext = [self heightForText:model.desc FontSize:14].size.height;
                CGFloat height_titletext = [self heightForText:model.title FontSize:16].size.height;
                CGFloat height_text = height_desctext+height_titletext+35;
                model.height = height_text;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        });
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MM_ListTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"MM_ListTableViewCell" owner:nil options:nil].lastObject;
    MM_ListModel *model = self.dataArr[indexPath.row];
    cell.title.text = model.title;
    cell.titleDesc.text = model.desc;
    cell.url = model.imageHref;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MM_ListModel *model = self.dataArr[indexPath.row];
    return model.height;
    
}

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


-(CGRect)heightForText:(NSString *)text FontSize:(CGFloat)fontSize{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-20-40-80, MAXFLOAT);
     NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    CGRect result = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    
    return result;
    
}
@end
