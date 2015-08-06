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

@end
