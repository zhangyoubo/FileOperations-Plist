//
//  Person.m
//  file
//
//  Created by Apple on 15/10/16.
//  Copyright (c) 2015年 zf. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize age,name,Phone;
-(id)initWithName:(NSString *)aName phone:(NSString *)aPhone age:(NSInteger)aAge
{
    self=[super init];
    if (self) {
        self.name=aName;
        self.age=aAge;
        self.Phone=aPhone;
    }
    return self;
}

//NSCoder协议(必须实现)

//将属性进行编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.Phone forKey:@"Phone"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    
}
//将属性进行解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name1 = [aDecoder decodeObjectForKey:@"name"];
    NSString *phone1 = [aDecoder decodeObjectForKey:@"Phone"];
    NSInteger age1 = [aDecoder decodeIntegerForKey:@"age"];
    
    id myself=[self initWithName:name1 phone:phone1 age:age1];
    
    return myself;
    
}

@end
