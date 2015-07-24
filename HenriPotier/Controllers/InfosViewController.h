//
//  InfosViewController.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 22/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  ViewController all the offers available
 */
@interface InfosViewController : UITableViewController

/**
 *  The basic price of the books
 */
@property (nonatomic, assign) CGFloat basicPrice;

/**
 *  Array of all the offers
 */
@property (nonatomic, strong) NSDictionary *offers;

@end
