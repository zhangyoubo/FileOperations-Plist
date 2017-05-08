//
//  Person.h
//  file
//
//  Created by Apple on 15/10/16.
//  Copyright (c) 2015年 zf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(assign)NSInteger age;
@property(retain)NSString *name;
@property(retain)NSString *Phone;
-(id)initWithName:(NSString *)aName phone:(NSString *)aPhone age:(NSInteger)aAge;
@end
