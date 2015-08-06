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

/**
 *  Method to setup the cell for a price and an offer
 *
 *  @param price The price
 *  @param price The offer
 */
- (void)setupForPrice:(CGFloat)price andOffer:(NSDictionary*)offer;

@end
