//
//  NSObject+Print.m
//  DrawText
//
//  Created by 黄露 on 2017/1/14.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "NSObject+Print.h"
#import <objc/runtime.h>

@implementation NSObject (Print)

- (NSString *)description
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableString *tempStr = [NSMutableString string];
    
    for (int i = 0; i < count; i ++) {
        NSString *property = [NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:property_getName(properties[i])]];
        
        id value = [self valueForKeyPath:property];
        
        [tempStr appendString:[NSString stringWithFormat:@"\n %@ : %@",property,value]];
    }
    return [NSString stringWithFormat:@"%@", tempStr];
}


+ (instancetype) modelWithDic:(NSDictionary *)dic {
    
    id obj = [[self alloc] init];
    
    //    利用runtime 给对象中的成员属性赋值
    //    claa_copyIvarList： 获取类中的成员属性
    //    Ivar ： 成员属性
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([obj class], &count);
    
    for (int i = 0; i < count;  i ++) {
        
        Ivar ivar = ivars[i];
        
        
        const char *ivarName = ivar_getName(ivar);
        
        //获取属性名
        NSString *name = [NSString stringWithUTF8String:ivarName];
        
        //获取变量类型
        NSString *nameType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];

        NSLog(@"nameType : %@",nameType);
        
        NSRange range = [nameType rangeOfString:@"\""];
        
        if (range.length != 0) {
            
            nameType = [nameType substringFromIndex:range.location + range.length];
            
            range = [nameType rangeOfString:@"\""];
            
            // 裁剪到哪个角标，不包括当前角标
            nameType = [nameType substringToIndex:range.location];
        }
        
        
        
        //处理成员属性名 ->字典中的key
        //从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        
        //根据成员属性名去字典中查找对应的value
        id value = dic[key];
        
         NSLog(@"%@ : %@",key ,value);
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        // 判断下value是否是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![nameType hasPrefix:@"NS"]) {
            // 字典转模型
            // 获取模型的类对象，调用modelWithDict
            // 模型的类名已知，就是成员属性的类型
            
            
            
            //根据字符串类名生成类对象
            Class modelClass = NSClassFromString(nameType);
            
            if (modelClass) {
                value = [modelClass modelWithDic:value];
            }
        }
        
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if (([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]] )&& ![nameType hasPrefix:@"NS"]) {
            
            //根据字符串类名生成类对象
            Class modelClass = NSClassFromString(nameType);
           
            
        }
        
        if (value) {
            [obj setValue:value forKey:key];
        }
    }
    
    return obj;
}



@end
