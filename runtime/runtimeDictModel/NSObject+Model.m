//
//  NSObject+Model.m
//  runtimeDictModel
//
//  Created by weiying on 16/3/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    id objc = [[self alloc] init];
    unsigned int count;
    //1、获取类中所有的成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↑⬇︎⬇︎⬇︎
        //2、根据下标，从成员列表中取出对应的成员变量
        //疑问：Ivar代表变量，为何指向数组带指针，指向普通变量不带指针？
        Ivar ivar = ivarList[i];
        //3、获取成员变量的名称
        const char *ivarName = ivar_getName(ivar);
        //转为将C字符串转为OC字符串
        NSString *name = [NSString stringWithUTF8String:ivarName];
        NSLog(@"name -- %@",name);
        //4、处理成员变量名称 -- 作为字典中的key
        //为什么要将成员变量从第一个位置做截取处理？因为成员变量会在前面生成一个下划线，如@“_age”
        NSString *key = [name substringFromIndex:1];
        NSLog(@"key -- %@",key);
        //5、根据成员变量名称的key去字典中查找对应的value
        id value = dict[key];
        //↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑⬆︎⬆︎⬆︎
        //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↑⬇︎⬇︎⬇︎
        //二级转换：如果字典中还有字典
        if ([value isKindOfClass:[NSDictionary class]]) {
            //获取成员变量的数据类型
            const char *ivarType = ivar_getTypeEncoding(ivar);
            NSString *type = [NSString stringWithUTF8String:ivarType];
            NSLog(@"dictType -- %@",type);//@\"NSDictionary\"
            
            //获取起始位置的转义符号和双引号\"
            NSRange range1 = [type rangeOfString:@"\""];
            NSLog(@"range -- %@",NSStringFromRange(range1));
            //从转义符之后开始截取子字符串
            NSString *subStr1 = [type substringFromIndex:range1.location + range1.length];
            //获取结束位置的转义符号和双引号\"
            NSRange range2 = [subStr1 rangeOfString:@"\""];
            //两个\"之间的内容就是该成员的类型名称
            NSString *classStr = [subStr1 substringToIndex:range2.location];
            
            //根据字符串名字生成类对象
            Class classModel = NSClassFromString(classStr);
            //进行二次转换
            if (classModel) {
                //字典转模型，并把模型赋值给value
                value = [classModel modelWithDict:value];
            }
        }
        //↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑⬆︎⬆︎⬆︎
        //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↑⬇︎⬇︎⬇︎
        //三级转换：如果字典中还有数组（数组中包含字典或非字典）
        if ([value isKindOfClass:[NSArray class]]) {
//            if ([self instancesRespondToSelector:@selector(arrayContainObjects)]) {
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                id idSelf = self;
                //根据字典中对应的key获取value
                NSString *arrValue = [idSelf arrayContainModelClass][key];
                NSLog(@"arrValue -- %@",arrValue);
                //根据字符串名称生成类对象
                Class classModel = NSClassFromString(arrValue);
                //遍历字典数组，生成模型数组
                NSMutableArray *mArr = [NSMutableArray array];
                for (NSDictionary *dict in value) {
                    //字典模型
                    id model = [classModel modelWithDict:dict];
                    [mArr addObject:model];
                }
                //把模型数组赋值给value
                value = mArr;
            }
        }
        //↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑⬆︎⬆︎⬆︎
        //6、用kvc对模型赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}


// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict
{
    // 创建对应模型对象
    id objc = [[self alloc] init];
    
    
    unsigned int count = 0;
    
    // 1.获取成员属性数组
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 2.遍历所有的成员属性名,一个一个去字典中取出对应的value给模型属性赋值
    for (int i = 0; i < count; i++) {
        
        // 2.1 获取成员属性
        Ivar ivar = ivarList[i];
        
        // 2.2 获取成员属性名 C -> OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 2.3 _成员属性名 => 字典key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 2.4 去字典中取出对应value给模型属性赋值
        id value = dict[key];
        
        
        // 获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 二级转换,字典中还有字典,也需要把对应字典转换成模型
        //
        // 判断下value,是不是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) { //  是字典对象,并且属性名对应类型是自定义类型
            // user User
            
            // 处理类型字符串 @\"User\" -> User
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            // 自定义对象,并且值是字典
            // value:user字典 -> User模型
            // 获取模型(user)类对象
            Class modalClass = NSClassFromString(ivarType);
            
            // 字典转模型
            if (modalClass) {
                // 字典转模型 user
                value = [modalClass objectWithDict:value];
            }
            
            // 字典,user
            //            NSLog(@"%@",key);
        }
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf arrayContainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    // 字典转模型
                    id model =  [classModel objectWithDict:dict];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;
                
            }
        }
        
        // 2.5 KVC字典转模型
        if (value) {
            
            [objc setValue:value forKey:key];
        }
    }
    
    
    // 返回对象
    return objc;
    
}


@end
