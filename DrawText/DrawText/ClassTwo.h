//
//  ClassTwo.h
//  DrawText
//
//  Created by 黄露 on 2017/1/13.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextModel.h"

@interface ClassTwo : NSObject

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *profff;
@property (nonatomic ,assign) NSInteger num;
@property (nonatomic ,strong) NSArray <TextModel *> *model;

- (instancetype) initWithDic:(NSDictionary *)dic;

@end
