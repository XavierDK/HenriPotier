//
//  DateHeaderTableView.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Basket.h"

@interface DateHeaderTableView : UIView

/**
 *  Initialization of table view section header of basket's history
 *
 *  @param frame  The frame of the header
 *  @param basket The basket of the header
 *
 *  @return The instance of the class
 */
- (id)initWithFrame:(CGRect)frame andBasket:(Basket*)basket;

@end
