//
//  ClassOne.m
//  DrawText
//
//  Created by 黄露 on 2017/1/13.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "ClassOne.h"
#import <objc/runtime.h>

@interface ClassOne ()

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,assign) NSInteger age;

@end

@implementation ClassOne {
    NSString *var4;
}

- (void) method_1 {
    
    NSLog(@"this is method 1");
}


void method(id self ,SEL _cmd ,NSNumber *num) {
    NSLog(@"run for %@",num);
}

+ (BOOL) resolveInstanceMethod:(SEL)sel {
    if (sel != NSSelectorFromString(@"method_1")) {
        class_addMethod(self, sel, (IMP)method,"v@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
