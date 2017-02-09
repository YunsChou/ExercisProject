//
//  ViewController.m
//  runtimeDictModel
//
//  Created by weiying on 16/3/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "ViewController.h"
#import "FoodData.h"
#import "FoodModel.h"
#import "NSObject+Model.h"
#import "NSObject+Property.h"
#import "TestModel.h"
#import "StatusModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //运行这段复杂的数据还是会崩溃
//    NSArray *foods = [FoodData foodData];
//    for (NSDictionary *foodDict in foods) {
//        FoodModel *foodM = [FoodModel modelWithDict:foodDict];
//    }
    
//    NSDictionary *foodDict = foods[0];
//    FoodModel *foodM = [FoodModel objectWithDict:foodDict];
    
    
    //可以解决下面几种相对简单的字段转模型
//    [self testModelEasy];
//    [self testModelHard];
    [self testModelStatus];
    //根据JSON的字段生成属性（目前只做了一层）
//    [self testModelProperty];
}

//
- (void)testModelEasy
{
    NSDictionary *dict = @{
                           @"abc" : @"123",
                           @"efg" : @"456"
                           };
    [TestModel modelWithDict:dict];
}

- (void)testModelHard
{
    NSDictionary *dict = @{
                           @"abc" : @"123",
                           @"efg" : @"456",
                           @"dic" : @{
                                    @"kkk" : @"987",
                                    @"iii" : @(456)
                                   },
                           @"subModel" : @{
                                   @"today" : @"今天",
                                   @"tommorrow" : @"明天"
                                   },
                           @"subArray" : @[@"i", @"need", @"you"],
                           @"subs" : @[
                                       @{
                                           @"today" : @"今天",
                                           @"tommorrow" : @"明天"
                                           },
                                       @{
                                           @"today" : @"今天",
                                           @"tommorrow" : @"明天"
                                           }
                                   ]
                           };
    
    TestModel *testM = [TestModel modelWithDict:dict];
    NSLog(@"testM -- %@",testM.subs);
    
    NSDictionary *dictTest = @{@"aa" : @"什么也木有"};
    NSLog(@"用字典中不存在的key去字典中取值，也是不会崩溃的-- %@",dictTest[@"bb"]);
}

- (void)testModelStatus
{
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.小码哥ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.小码哥ad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    StatusModel *statusM = [StatusModel objectWithDict:dict];
    NSLog(@"statuses -- %@",statusM.statuses);
    NSLog(@"ads -- %@",statusM.ads);
}

- (void)testModelProperty
{
    NSDictionary *dict = @{
                           @"abc" : @"123",
                           @"efg" : @"456",
                           @"dic" : @{
                                   @"kkk" : @"987",
                                   @"iii" : @(456)
                                   },
                           @"subModel" : @{
                                   @"today" : @"今天",
                                   @"tommorrow" : @"明天"
                                   },
                           @"subArray" : @[@"i", @"need", @"you"],
                           @"isBool" : @(YES),
                           @"number" : @(10)
                           };
    
    [dict createPropertyCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
