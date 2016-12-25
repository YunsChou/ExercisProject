//
//  Animal.h
//  EX-RAC-DEMO
//
//  Created by Yuns on 2016/12/25.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

- (Animal *)run;

- (Animal *)jump;

- (Animal *)say:(NSString *)words;

@end
