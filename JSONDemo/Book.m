//
//  Book.m
//  JSONDemo
//
//  Created by vera on 15/7/26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)setValue:(id)value forKey:(NSString *)key
{
    //图片
    if ([key isEqualToString:@"images"])
    {
        _large = value[@"large"];
    }
    else
    {
        [super setValue:value forKey:key];
    }
    
    
}

//setValue:forKey:key不存在会触发
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//valueForKey:key不存在会触发
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
