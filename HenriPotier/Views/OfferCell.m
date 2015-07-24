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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
