//
//  ZYPersonInfo.m
//  MJExtension_Explore
//
//  Created by ZhouYong on 16/12/16.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import "ZYPersonInfo.h"

@implementation ZYPersonInfo

#pragma mark
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    
//}

@end


@implementation ZYPersonInfo_UnsamePropertyName

#pragma mark  下面这方法与在数据解析的时候调用mj_setupReplacedKeyFromPropertyName方法效果相同,写在模型里面的好处是:一旦这个类在多个地方被请求调用,那么在类方法里面只要写一次下面方法就可以了,也就是在数据解析的地方不需要再做属性名和返回的数据字典里面key值不相同的处理了.
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"gay":@"gay1",
             @"Extra":@"extra"
             };

}

@end
