//
//  OfferCell.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 22/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *offerType;
@property (nonatomic, weak) IBOutlet UILabel *offerValue;
@property (nonatomic, weak) IBOutlet UILabel *offerResult;

@end
