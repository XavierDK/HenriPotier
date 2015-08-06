//
//  BasketViewControllerDataSource.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BasketViewControllerDataSource.h"
#import "BookBoughtCell.h"
#import "PriceCell.h"
#import "BooksManager.h"


static NSString * const bookBoughtIdentifier = @"BookBoughtCell";
static NSString * const priceIdentifier = @"PriceCell";


@implementation BasketViewControllerDataSource

- (void)setBooksSelected:(NSArray *)booksSelected
{
    _booksSelected = booksSelected;
    self.basicPrice = [BooksManager totalPriceForBooks:_booksSelected];
    self.bestPrice = self.basicPrice;
}

- (void)setOffers:(NSDictionary *)offers
{
    _offers = offers;
    
    self.bestPrice = [BooksManager bestPriceForOffers:self.offers andBasicPrice:self.basicPrice];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksSelected.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.row < self.booksSelected.count)
    {
        BookBoughtCell *bookCell = [tableView dequeueReusableCellWithIdentifier:bookBoughtIdentifier forIndexPath:indexPath];
        
        [bookCell setupForBook:self.booksSelected[indexPath.row]];
        
        cell = bookCell;
    }
    
    else if (indexPath.row == self.booksSelected.count)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];

        [priceCell setupForPrice:self.basicPrice andTitle:NSLocalizedString(@"TOTAL", nil)];
        
        cell = priceCell;
    }
    
    else if (indexPath.row == self.booksSelected.count + 1)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        [priceCell setupForPrice:self.bestPrice andTitle:NSLocalizedString(@"TOTAL AFTER OFFER", nil)];
        
        cell = priceCell;
    }
    
    return cell;
}

@end
