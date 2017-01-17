//
//  ClassTwo.m
//  DrawText
//
//  Created by 黄露 on 2017/1/13.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "ClassTwo.h"
#import <objc/runtime.h>

@implementation ClassTwo

- (instancetype) initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i ++) {
            const char *property = property_getName(properties[i]);
            NSString *pro = [NSString stringWithUTF8String:property];
            id value = [dic objectForKey:pro];
            
            NSString *propertyType = [NSString stringWithUTF8String:property_getAttributes(properties[i])];
            
            if ([value isKindOfClass:[NSDictionary class]] && [propertyType containsString:@"NS"]) {
                //进行耳机转换
                //获取二级模型类型进行字符串截取，转换为类名
                NSRange range = [propertyType rangeOfString:@"\""];
                propertyType = [propertyType substringFromIndex:range.location + range.length];
            }
            
            [self setValue:value forKey:pro];
        }
    }
    
    return self;
}




@end
