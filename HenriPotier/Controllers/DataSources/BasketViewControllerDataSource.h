//
//  BasketViewControllerDataSource.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BasketViewControllerDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

/**
 *  The books selected
 */
@property (nonatomic, strong) NSArray *booksSelected;

/**
 *  The offers available
 */
@property (nonatomic, strong) NSDictionary *offers;

/**
 *  The basic price of the books
 */
@property (nonatomic, assign) CGFloat basicPrice;

/**
 *  The best price after offer application
 */
@property (nonatomic, assign) CGFloat bestPrice;


@end
