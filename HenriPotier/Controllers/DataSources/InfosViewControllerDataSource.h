//
//  InfosViewControllerDataSource.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InfosViewControllerDataSource : NSObject<UITableViewDataSource>

/**
 *  All the prices calculated
 */
@property (nonatomic, strong) NSArray *prices;

/**
 *  Array of all the offers
 */
@property (nonatomic, strong) NSDictionary *offers;

@end
