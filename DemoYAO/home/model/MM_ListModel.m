//
//  MM_ListModel.m
//  DemoYAO
//
//  Created by yuchen_Mac on 2018/2/27.
//  Copyright © 2018年 yuchen_Mac. All rights reserved.
//

#import "MM_ListModel.h"

#define Format(paramete) [paramete isKindOfClass:[NSString class]]?paramete:[NSString stringWithFormat:@"%@",paramete]

@implementation MM_ListModel

-(instancetype)initWithDictionry:(NSDictionary*)dict{
    
    self = [super init];
    if (self) {
        self.desc = Format(dict[@"description"]);
        self.imageHref = Format(dict[@"imageHref"]);
        self.title = Format(dict[@"title"]);
    }
    return self;
}
@end
