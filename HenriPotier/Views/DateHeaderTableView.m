//
//  DateHeaderTableView.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "DateHeaderTableView.h"
#import <OpenSans/UIFont+OpenSans.h>
#import "Basket.h"

@implementation DateHeaderTableView

- (id)initWithFrame:(CGRect)frame andBasket:(Basket*)basket
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f]];
        
        UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 10*2, 25.f)];
        [dateLbl setFont:[UIFont openSansSemiBoldFontOfSize:18.f]];
        [dateLbl setTextColor:[UIColor whiteColor]];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy HH:mm"];
        
        dateLbl.text = [df stringFromDate:basket.date];
        [self addSubview:dateLbl];
    }
    return self;
}

@end
