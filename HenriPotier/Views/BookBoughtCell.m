//
//  BookBoughtCell.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BookBoughtCell.h"
#import <OpenSans/UIFont+OpenSans.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation BookBoughtCell

- (void)awakeFromNib {
    
    self.titleLabel.font = [UIFont openSansSemiBoldFontOfSize:18.f];
    self.priceLabel.font = [UIFont openSansSemiBoldFontOfSize:16.f];
}

- (void)setupForBook:(NSDictionary*)book
{
    [self.imgView setImageWithURL:[NSURL URLWithString:book[@"cover"]]];
    self.titleLabel.text = book[@"title"];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ €", book[@"price"]];
}

@end
