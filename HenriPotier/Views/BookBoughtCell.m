//
//  BookBoughtCell.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BookBoughtCell.h"
#import <OpenSans/UIFont+OpenSans.h>

@implementation BookBoughtCell

- (void)awakeFromNib {
    
    self.titleLabel.font = [UIFont openSansSemiBoldFontOfSize:18.f];
    self.priceLabel.font = [UIFont openSansSemiBoldFontOfSize:16.f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
