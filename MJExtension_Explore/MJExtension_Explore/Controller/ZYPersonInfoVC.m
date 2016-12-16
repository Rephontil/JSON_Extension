//
//  ZYPersonInfoVC.m
//  MJExtension_Explore
//
//  Created by ZhouYong on 16/12/16.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import "ZYPersonInfoVC.h"
#import "ZYPersonInfo.h"
#import <MJExtension.h>

@interface ZYPersonInfoVC ()

@end

@implementation ZYPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self obtainPersonInfo];
    
    [self obtainPersonInfo_UnsamePropertyName];
}

#pragma mark The most simple JSON -> Model【最简单的字典转模型】
- (void)obtainPersonInfo
{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @"1.55",
                           @"money" : @100.9,
                           @"sex" : @(SexFemale),
                           @"gay1" : @"true",
                           //   @"gay" : @"1"
                           //   @"gay" : @"NO"
                           };
    
    ZYPersonInfo *personInfo = [ZYPersonInfo mj_objectWithKeyValues:dict];
    
//    注: 下面这种是采用系统的写法获取模型的,需要对模型进行初始化.
//    ZYPersonInfo *personInfo = [ZYPersonInfo new];
//    [personInfo setValuesForKeysWithDictionary:dict];
    
    NSLog(@"name=%@, icon=%@, age=%zd, height=%@, money=%@, sex=%d, gay=%d", personInfo.name, personInfo.icon, personInfo.age, personInfo.height, personInfo.money, personInfo.sex, personInfo.gay);

}

#pragma mark Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
- (void)obtainPersonInfo_UnsamePropertyName
{
    NSDictionary *dict = @{
                           @"id" : @"20124823566",
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @"1.69",
                           @"money" : @100.9,
                           @"sex" : @(SexFemale),
                           @"gay1" : @"true",
                           @"extra" : @"scholarship"
                          
                           };
    
#pragma mark  下面这种对属性直接进行一个字典形式的替换,其方法等效于下面的效果,但是对于很多属性更快吧
//    [ZYPersonInfo_UnsamePropertyName mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"ID":@"id",
//                 @"gay":@"gay1",
//                 @"Extra":@"extra"
//                 };
//        
//    }];
    
    /*
#pragma mark  下面这种需要一个一个地做判断,其方法等效于上面的效果
    [ZYPersonInfo_UnsamePropertyName mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        if ([propertyName isEqualToString:@"gay"]) {
            propertyName = @"gay1";
        }
        if ([propertyName isEqualToString:@"ID"]) {
            propertyName = @"id";
        }
        if ([propertyName isEqualToString:@"Extra"]) {
            propertyName = @"extra";
        }
        return propertyName;
    }];
    */
    
    ZYPersonInfo_UnsamePropertyName *personInfo = [ZYPersonInfo_UnsamePropertyName mj_objectWithKeyValues:dict];
    NSLog(@"id=%@,name=%@, icon=%@, age=%zd, height=%@, money=%@, sex=%d, gay=%d,extra=%@",personInfo.ID, personInfo.name, personInfo.icon, personInfo.age, personInfo.height, personInfo.money, personInfo.sex, personInfo.gay,personInfo.Extra);
    
}


@end










