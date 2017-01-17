//
//  ViewController.m
//  DrawText
//
//  Created by 黄露 on 2017/1/13.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "ViewController.h"
#import "ClassOne.h"
#import "ClassTwo.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+Print.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
//    imageView.center = self.view.center;
//    [self.view addSubview:imageView];
//    
//    UIImage *image = [UIImage imageNamed:@"首页"];
//    
//    NSString *shuiyi = @"shuiying";
//    
//    UIGraphicsBeginImageContext(image.size);
//    
//    [image drawInRect:imageView.bounds];
//    
//    [shuiyi drawInRect:CGRectMake(imageView.bounds.size.width / 2, 50, 100, 20) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],
//                                                         NSForegroundColorAttributeName:[UIColor blueColor]}];
//    
////    [shuiyi drawAtPoint:imageView.center withAttributes:@{
////                                                          NSFontAttributeName:[UIFont systemFontOfSize:20],
////                                                          NSForegroundColorAttributeName:[UIColor yellowColor]
////                                                          }];
//    
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    imageView.image = newImage;
    
//    ClassOne *one = [ClassOne new];
    
    unsigned int count = 0;
    unsigned int p_count = 0;
    Ivar *vars = class_copyIvarList([ClassOne class], &count);
    objc_property_t *vars_ps = class_copyPropertyList([ClassOne class], &p_count);
 
    for (int i = 0 ; i < count; i ++) {
        Ivar var = vars[i];
        
        const char *propertyName = ivar_getName(var);
//        const char *property =
        const char *propertyType = ivar_getTypeEncoding(var);
        
        NSLog(@"\n name : %@ , \n type = %@",[NSString stringWithUTF8String:propertyName], [NSString stringWithUTF8String:propertyType]);
    }
    
    printf("-----------------------------\n");
    
    for (int i = 0; i < p_count; i ++ ) {
        
        objc_property_t pro = vars_ps[i];
        const char *pros = property_getName(pro);
        const char *proType = property_getAttributes(pro);
        NSLog(@"\n name : %@ , \n type = %@",[NSString stringWithUTF8String:pros], [NSString stringWithUTF8String:proType]);
    }
    
    /**
     @property (nonatomic ,copy) NSString *name;
     @property (nonatomic ,copy) NSString *profff;
     @property (nonatomic ,assign) NSInteger num;
     */
    
    NSLog(@"==================================");
    
    NSDictionary *dic = @{
                          @"name":@"sfsfs",
                          @"profff":@"sfsf",
                          @"num":@"1234",
                          @"model":@[
                                  @{
                                  @"model1":@"model1",
                                  @"model2":@"model2"
                                  },@{
                                          @"model1":@"model1",
                                          @"model2":@"model2"
                                          }]
                          };
    
    ClassTwo *two = [ClassTwo modelWithDic:dic];
    NSLog(@"model ; %@ ",self.view);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
