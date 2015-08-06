//
//  OfferCell.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 22/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "OfferCell.h"
#import <UIFont+OpenSans.h>

@implementation OfferCell

- (void)awakeFromNib
{
    self.offerType.font = [UIFont openSansSemiBoldFontOfSize:16.f];
    self.offerValue.font = [UIFont openSansSemiBoldFontOfSize:16.f];
    self.offerResult.font = [UIFont openSansSemiBoldFontOfSize:16.f];
}

- (void)setupForPrice:(CGFloat)price andOffer:(NSDictionary*)offer
{
    self.offerType.text = [NSString stringWithFormat:@"Type : %@", [NSLocalizedString(offer[@"type"], nil) uppercaseString]];
    
    if ([offer[@"type"] isEqualToString:@"percentage"])
    {
        self.offerValue.text = [NSString stringWithFormat:NSLocalizedString(@"Value: %@%%", nil), offer[@"value"]];
    }
    else if ([offer[@"type"] isEqualToString:@"minus"])
    {
        self.offerValue.text = [NSString stringWithFormat:NSLocalizedString(@"Value: %@€", nil), offer[@"value"]];
    }
    else if ([offer[@"type"] isEqualToString:@"slice"])
    {
        self.offerValue.text = [NSString stringWithFormat:NSLocalizedString(@"SliceValue: %@€, Value: %@€", nil), offer[@"sliceValue"], offer[@"value"]];
    }
    
    self.offerResult.text = [NSString stringWithFormat:NSLocalizedString(@"Result price : %.2f€", nil), price];
}

@end
