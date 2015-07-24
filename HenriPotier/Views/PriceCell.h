//
//  PriceCell.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The table cell for showing a price
 */
@interface PriceCell : UITableViewCell

/**
 *  The title of the price
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

/**
 *  The price value
 */
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end
