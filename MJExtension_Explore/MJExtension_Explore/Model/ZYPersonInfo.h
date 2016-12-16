//
//  ZYPersonInfo.h
//  MJExtension_Explore
//
//  Created by ZhouYong on 16/12/16.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

typedef enum {
    SexMale,
    SexFemale
} Sex;


@interface ZYPersonInfo : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (assign, nonatomic, getter=isGay) BOOL gay;

@end



@interface ZYPersonInfo_UnsamePropertyName : NSObject

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (assign, nonatomic, getter=isGay) BOOL gay;
@property (strong, nonatomic) NSString *Extra;

@end



@interface User : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;

@end


@interface Status : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Status *retweetedStatus;
@end




@interface ZYAd : NSObject
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *url;
@end



@interface ZYStatusResult : NSObject
/** Contatins status model */
@property (strong, nonatomic) NSMutableArray *statuses;
/** Contatins ad model */
@property (strong, nonatomic) NSArray *ads;
@property (strong, nonatomic) NSNumber *totalNumber;
@end



@interface ZYBag : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) double price;
@end



@interface ZYStudent : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *nowName;
@property (copy, nonatomic) NSString *oldName;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (strong, nonatomic) ZYBag *bag;
@end





