//
//  OfferCell.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 22/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The table cell to show a specific offer
 */
@interface OfferCell : UITableViewCell

/**
 *  The type of the offer
 */
@property (nonatomic, weak) IBOutlet UILabel *offerType;

/**
 *  The value of the offer
 */
@property (nonatomic, weak) IBOutlet UILabel *offerValue;

/**
 *  The result price after the offer
 */
@property (nonatomic, weak) IBOutlet UILabel *offerResult;

@end
