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
#import <AFNetworking.h>

@interface ZYPersonInfoVC ()

@end

@implementation ZYPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self obtainPersonInfo];

    //    [self obtainPersonInfo_UnsamePropertyName];
    //
    //    [self jsonString2Model];

    //    [self modelWithModel];
    //    [self modelContainsModelArray];

    //    [self jsonArray2ModelArray];
    
    //[self modelWithUnSamePropertyNameOrMutiply];
    
    [self codingArchive];

    //    [self dataList];
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

#pragma mark JSONString -> Model【JSON字符串转模型】
- (void)jsonString2Model
{
    // 1.Define a JSONString
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";

    // 2.JSONString -> User
    User *user = [User mj_objectWithKeyValues:jsonString];

    // 3.Print user's properties
    NSLog(@"name=%@, icon=%@, age=%d", user.name, user.icon, user.age);
    // name=Jack, icon=lufy.png, age=20
}

#pragma mark  Model contains model【模型中嵌套模型】
- (void)modelWithModel
{
    NSDictionary *dict = @{
                           @"text" : @"Agree!Nice weather!",
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           @"retweetedStatus" : @{
                                   @"text" : @"Nice weather!",
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };

    // 如果用系统自带的方法进行数据解析就会有问题啦，下面两行是错误的❎！！！
    //    Status *status = [Status new];   //❌
    //    [status setValuesForKeysWithDictionary:dict]; // ❌


    Status *status = [Status mj_objectWithKeyValues:dict];
    NSLog(@"status.text=%@\n status.user.name=%@\n status.user.icon=%@\n status.retweetedStatus.text=%@\n status.retweetedStatus.user.name=%@\n status.retweetedStatus.user.icon=%@",status.text,status.user.name,status.user.icon,status.retweetedStatus.text,status.retweetedStatus.user.name,status.retweetedStatus.user.icon);
}


#pragma mark Model contains model-array【模型中有个数组属性，数组里面又要装着其他模型】
- (void)modelContainsModelArray
{
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   @{
                                       @"text" : @"Go camping tomorrow!",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.ad02.com"
                                       }
                                   ],
                           @"totalNumber" : @"2014"
                           };

#pragma mark  在模型里面实现另外一个方法：（ +mj_objectClassInArray）也可以达到同样的效果
    // Tell MJExtension what type model will be contained in statuses and ads.
    [ZYStatusResult mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses":@"Status",
                 // @"statuses" : [Status class],
                 @"ads":@"ZYAd"
                 // @"ads" : [ZYAd class]
                 };
    }];

    ZYStatusResult *statusResult = [ZYStatusResult mj_objectWithKeyValues:dict];
    NSLog(@"statusResult.statuses=%@",statusResult.statuses);

    for (Status *status in statusResult.statuses) {
        NSLog(@"status.text=%@\nstatus.user%@",status.text,status.user.name);
    }
    for (ZYAd *ad in statusResult.ads) {
        NSLog(@"statusResult.ad.image=%@\nstatusResult.ad.image=%@",ad.image,ad.url);
    }

}

#pragma mark JSON array -> model array【将一个字典数组转成模型数组】
- (void)jsonArray2ModelArray
{
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png"
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png"
                               }
                           ];
    NSArray *userArray = [User mj_objectArrayWithKeyValuesArray:dictArray];
    for (User *user in userArray) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);
    }


}

#pragma mark Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
- (void)modelWithUnSamePropertyNameOrMutiply
{
    // How to map
    [ZYStudent mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"desc" : @"desciption",
                 @"oldName" : @"name.oldName",
                 @"nowName" : @"name.newName",
                 @"nameChangedTime" : @"name.info[1].nameChangedTime",
                 @"bag" : @"other.bag"
                 };
    }];
    // Equals: Student.m implements +mj_replacedKeyFromPropertyName method.
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"kids",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{
                                               @"nameChangedTime" : @"2013-08"
                                               }
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"a red bag",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    // JSON -> Student
    ZYStudent *stu = [ZYStudent mj_objectWithKeyValues:dict];

    // Printing
    NSLog(@"ID=%@, desc=%@, oldName=%@, nowName=%@, nameChangedTime=%@",
          stu.ID, stu.desc, stu.oldName, stu.nowName, stu.nameChangedTime);
    // ID=20, desc=kids, oldName=kitty, nowName=lufy, nameChangedTime=2013-08
    NSLog(@"bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
    // bagName=a red bag, bagPrice=100.700000

}

- (void)codingArchive
{
    [ZYBag mj_setupAllowedCodingPropertyNames:^NSArray *{
        return @[@""];
    }];
    ZYBag *bag = [[ZYBag alloc] init];
    bag.name = @"Nick";
    bag.price = 169.99;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"codingArchive.data"];
    [NSKeyedArchiver archiveRootObject:bag toFile:filePath];
    
    ZYBag *bagInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"bag.name = %@,bag.price = %f",bagInfo.name,bagInfo.price);
    
    
}


- (void)dataList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://djctestng.517w.com/dacu_app/app/?c=UserSetting&a=get_cartoon_setting_list&userid=683721&start=0&ui=0&ui_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-->%@",responseObject);
        
    } failure:nil];
}



@end









