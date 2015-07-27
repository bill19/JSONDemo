//
//  Book.h
//  JSONDemo
//
//  Created by vera on 15/7/26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

/**
 图书名字
 */
@property (nonatomic, copy) NSString *title;

/**
 图书价格
 */
@property (nonatomic, copy) NSString *price;

/**
 图书大图
 */
@property (nonatomic, copy) NSString *large;

@end
