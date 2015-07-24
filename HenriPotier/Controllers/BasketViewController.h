//
//  BasketViewController.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  ViewController to show the basket of the books selected
 */
@interface BasketViewController : UITableViewController

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
