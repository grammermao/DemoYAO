//
//  MM_ListTableViewCell.h
//  DemoYAO
//
//  Created by yuchen_Mac on 2018/2/27.
//  Copyright © 2018年 yuchen_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MM_ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *titleDesc;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
