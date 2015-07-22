//
//  BookCell.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BookCell.h"
#import <OpenSans/UIFont+OpenSans.h>
#import <QuartzCore/QuartzCore.h>

@implementation BookCell

- (void)awakeFromNib
{
    self.layer.borderColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:.5f].CGColor;
    self.layer.borderWidth = 1.0f;
    [self.layer setCornerRadius:5.0f];
    
    self.titleLabel.font = [UIFont openSansFontOfSize:13.f];
    self.titleLabel.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    
    self.priceLabel.font = [UIFont openSansFontOfSize:11.f];
    self.priceLabel.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
}

@end