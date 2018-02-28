//
//  MM_ListModel.h
//  DemoYAO
//
//  Created by yuchen_Mac on 2018/2/27.
//  Copyright © 2018年 yuchen_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MM_ListModel : NSObject

/// 描述
@property (copy, nonatomic) NSString *desc;
/// 图片
@property (copy, nonatomic) NSString *imageHref;
/// 标题
@property (copy, nonatomic) NSString *title;

-(instancetype)initWithDictionry:(NSDictionary*)dict;
@end
