//
//  MM_ListTableViewCell.m
//  DemoYAO
//
//  Created by yuchen_Mac on 2018/2/27.
//  Copyright © 2018年 yuchen_Mac. All rights reserved.
//

#import "MM_ListTableViewCell.h"

@implementation MM_ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(MM_ListModel *)model{
    self.title.text = model.title;
    self.titleDesc.text = model.desc;
    
}
-(void)setUrl:(NSString *)url{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        CGSize imageSize=[UIImage imageWithData:data].size;
        CGFloat scanl =  imageSize.width/80.0;
        if (scanl != 0) {
            CGFloat height = imageSize.height /scanl;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, height)];
                [imageview setCenter:self.imageV.center];
                [imageview sd_setImageWithURL:[NSURL URLWithString:url]];
                [self addSubview:imageview];
                // 判断cell的高度 
            });
        }
   
    });
}


@end
