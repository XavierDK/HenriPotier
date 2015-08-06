//
//  HeaderTutorialReusableView.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 20/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "HeaderTutorialReusableView.h"
#import <OpenSans/UIFont+OpenSans.h>

@implementation HeaderTutorialReusableView

- (void)awakeFromNib
{
    self.titleLabel.font = [UIFont openSansLightItalicFontOfSize:30.f];
    self.descriptionLabel.font = [UIFont openSansFontOfSize:14.f];
    
    self.titleLabel.text = @"Henri Potier";
    self.descriptionLabel.text = NSLocalizedString(@"Click on the books that you want to buy and press the button confirm. You will discover our best offer!", nil);
}

@end
