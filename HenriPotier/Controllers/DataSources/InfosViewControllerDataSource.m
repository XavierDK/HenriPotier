//
//  InfosViewControllerDataSource.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "InfosViewControllerDataSource.h"
#import "OfferCell.h"

@implementation InfosViewControllerDataSource

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.prices.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferCell"];
    [cell setupForPrice:[self.prices[indexPath.row] floatValue] andOffer:self.offers[@"offers"][indexPath.row]];
    
    return cell;
}

@end
