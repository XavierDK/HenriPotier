//
//  HistoryViewController.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 23/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The ViewController to show all the basket purchased
 */
@interface HistoryViewController : UITableViewController

/**
 *  Array of all the baskets
 */
@property (nonatomic, strong) NSArray *baskets;

/**
 *  Array of all the books for the baskets
 */
@property (nonatomic, strong) NSMutableArray *basketsBooks;

@end
