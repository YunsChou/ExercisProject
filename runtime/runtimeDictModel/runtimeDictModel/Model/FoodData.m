//
//  FoodData.m
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "FoodData.h"

@implementation FoodData

+ (NSArray *)foodData
{
    NSArray *foods = @[
                       @{
                           @"title"    : @"米饭",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"1",
                                       @"foodName"  : @"白米饭",
                                       @"foodImage" : @"http://img1.sc115.com/uploads/sc/jpg/HD/30/2004.jpg",
                                       @"foodPrice" : @"1.5",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"2",
                                       @"foodName"  : @"玉米饭",
                                       @"foodImage" : @"http://i5.xiachufang.com/image/600/b4cf54eca03711e38844b8ca3aeed2d7.jpg",
                                       @"foodPrice" : @"2.0",
                                       @"saleStatus": @"1"
                                       }
                                   ]
                           },
                       
                       @{
                           @"title"    : @"炒菜",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"3",
                                       @"foodName"  : @"家常豆腐",
                                       @"foodImage" : @"http://ningbo.sinaimg.cn/2013/0514/U9515P1480DT20130514160143.jpg",
                                       @"foodPrice" : @"12",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"4",
                                       @"foodName"  : @"青椒肉丝",
                                       @"foodImage" : @"http://pic38.nipic.com/20140221/8709082_165152695000_2.jpg",
                                       @"foodPrice" : @"15",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"5",
                                       @"foodName"  : @"鱼香肉丝",
                                       @"foodImage" : @"http://pic39.nipic.com/20140308/9370364_103332481000_2.jpg",
                                       @"foodPrice" : @"15",
                                       @"saleStatus": @"0"
                                       },
                                   @{
                                       @"foodId"    : @"6",
                                       @"foodName"  : @"宫保鸡丁",
                                       @"foodImage" : @"http://p1.55tuanimg.com/static/goods/richText/2014/06/25/17/096d203c507ffd734c83ff4d32826078_690_430.jpg",
                                       @"foodPrice" : @"18",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"7",
                                       @"foodName"  : @"剁椒鱼头",
                                       @"foodImage" : @"http://picapi.ooopic.com/01/39/38/67b1OOOPIC18.jpg",
                                       @"foodPrice" : @"20",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"8",
                                       @"foodName"  : @"孜然牛肉",
                                       @"foodImage" : @"http://shandong.sinaimg.cn/2014/0112/U10604P1333DT20140112113119.jpg",
                                       @"foodPrice" : @"25",
                                       @"saleStatus": @"1"
                                       }
                                   ]
                           },
                       
                       @{
                           @"title"    : @"火锅",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"9",
                                       @"foodName"  : @"鱼肉火锅",
                                       @"foodImage" : @"http://a2.att.hudong.com/40/65/01300000738006126926651830746.jpg",
                                       @"foodPrice" : @"30",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"10",
                                       @"foodName"  : @"羊肉火锅",
                                       @"foodImage" : @"http://h.hiphotos.baidu.com/lbc/w%3D448%3Bq%3D90/sign=a2958642950a304e5222a1fee9f3d6bb/63d9f2d3572c11dff6664d65612762d0f603c2c5.jpg",
                                       @"foodPrice" : @"45",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"11",
                                       @"foodName"  : @"牛肉火锅",
                                       @"foodImage" : @"http://p0.55tuanimg.com/static/goods/ckeditor/2012/03/28/14ckeditor_1332914626_5208.jpg",
                                       @"foodPrice" : @"50",
                                       @"saleStatus": @"0"
                                       },
                                   @{
                                       @"foodId"    : @"12",
                                       @"foodName"  : @"土鸡火锅",
                                       @"foodImage" : @"http://p3.55tuanimg.com/static/goods/richText/2013/12/20/10/d00698681531240939e10f2bc73244b5_690_460.jpg",
                                       @"foodPrice" : @"50",
                                       @"saleStatus": @"1"
                                       }
                                   ]
                           },
                       
                       @{
                           @"title"    : @"干锅",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"11",
                                       @"foodName"  : @"鸡杂干锅",
                                       @"foodImage" : @"http://pic36.nipic.com/20131226/4418117_213724285125_2.jpg",
                                       @"foodPrice" : @"25",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"12",
                                       @"foodName"  : @"羊杂干锅",
                                       @"foodImage" : @"http://pic74.nipic.com/file/20150805/20578453_202503776000_2.jpg",
                                       @"foodPrice" : @"35",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"13",
                                       @"foodName"  : @"牛杂干锅",
                                       @"foodImage" : @"http://pic48.nipic.com/file/20140911/9885883_225149196000_2.jpg",
                                       @"foodPrice" : @"45",
                                       @"saleStatus": @"0"
                                       }
                                   ]
                           },

                       @{
                           @"title"    : @"凉菜",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"14",
                                       @"foodName"  : @"青椒皮蛋",
                                       @"foodImage" : @"http://imgs.douguo.com/upload/diet/e/b/1/ebc8246c5326bc778d08928772940c91.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"14",
                                       @"foodName"  : @"酸辣海带丝",
                                       @"foodImage" : @"http://p0.meituan.net/deal/4dc8d3df4ffb553042243a41cf3843c8237141.jpg",
                                       @"foodPrice" : @"5",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"15",
                                       @"foodName"  : @"糖醋花生米",
                                       @"foodImage" : @"http://img3.imgtn.bdimg.com/it/u=3206177220,1157250595&fm=21&gp=0.jpg",
                                       @"foodPrice" : @"5",
                                       @"saleStatus": @"1"
                                       }
                                   ]
                           },

                       @{
                           @"title"    : @"汤类",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"16",
                                       @"foodName"  : @"紫菜蛋汤",
                                       @"foodImage" : @"http://p1.55tuanimg.com/static/goods/richText/2014/06/10/15/903886d1cc9a16282ddee8668cdd7779_690_460.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"17",
                                       @"foodName"  : @"番茄蛋汤",
                                       @"foodImage" : @"http://b.hiphotos.baidu.com/lbc/w%3D448%3Bq%3D90/sign=6ac10670d60735fa91f04fbda66a7e8e/242dd42a2834349bc2e2caeecbea15ce37d3bef1.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"18",
                                       @"foodName"  : @"豆腐汤",
                                       @"foodImage" : @"http://images.meishij.net/p/20110831/0b25b34acf3bfb33907803c9d6e11d0b.jpg",
                                       @"foodPrice" : @"6",
                                       @"saleStatus": @"0"
                                       }
                                   ]
                           },

                       
                       @{
                           @"title"    : @"稀饭",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"19",
                                       @"foodName"  : @"皮蛋廋肉粥",
                                       @"foodImage" : @"http://i5.qhimg.com/t01de275ea99faca89d.jpg",
                                       @"foodPrice" : @"5",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"20",
                                       @"foodName"  : @"南瓜粥",
                                       @"foodImage" : @"http://i3.s1.dpfile.com/pc/ac7b950817f430df6a691c2cb8bda74f%28700x700%29/thumb.jpg",
                                       @"foodPrice" : @"3",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"21",
                                       @"foodName"  : @"青菜粥",
                                       @"foodImage" : @"http://image.enmuo.com/CMS/2012/09/25/1/CMS_120925150918188_0E_600x400.jpg",
                                       @"foodPrice" : @"3",
                                       @"saleStatus": @"1"
                                       }
                                   ]
                           },

                       @{
                           @"title"    : @"面食",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"22",
                                       @"foodName"  : @"小面",
                                       @"foodImage" : @"http://i1.s1.dpfile.com/pc/ccccef535562d0341e19a06394452a91%28700x700%29/thumb.jpg",
                                       @"foodPrice" : @"6",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"23",
                                       @"foodName"  : @"燃面",
                                       @"foodImage" : @"http://upload3.xiaomishu.com/Topics/20120213/e851446a-01b9-43ca-b929-6eadb543e5ea.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"24",
                                       @"foodName"  : @"热干面",
                                       @"foodImage" : @"http://www.hnlxgl.com/files/document/10000/2014/12/1417500276069113.jpg",
                                       @"foodPrice" : @"6",
                                       @"saleStatus": @"1"
                                       }
                                   ]
                           },
                       
                       @{
                           @"title"    : @"时蔬",
                           @"foodSubs" : @[
                                   @{
                                       @"foodId"    : @"25",
                                       @"foodName"  : @"小白菜",
                                       @"foodImage" : @"http://pic.baike.soso.com/p/20131220/20131220040356-277986631.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"26",
                                       @"foodName"  : @"大白菜",
                                       @"foodImage" : @"http://www.cqxdfpr.com/uploads/allimg/121123/14_121123082011_1.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"1"
                                       },
                                   @{
                                       @"foodId"    : @"27",
                                       @"foodName"  : @"生菜",
                                       @"foodImage" : @"http://img3.redocn.com/tupian/20141112/suchaoshengcai_3419711.jpg",
                                       @"foodPrice" : @"8",
                                       @"saleStatus": @"0"
                                       }
                                   ]
                           }
                       ];
    
    return foods;
    
}

@end
