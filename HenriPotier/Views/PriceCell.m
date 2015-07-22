//
//  PriceCell.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "PriceCell.h"
#import <OpenSans/UIFont+OpenSans.h>

@implementation PriceCell

- (void)awakeFromNib {

    self.titleLabel.font = [UIFont openSansSemiBoldFontOfSize:16.f];
    self.priceLabel.font = [UIFont openSansSemiBoldFontOfSize:16.f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
