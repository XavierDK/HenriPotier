//
//  HistoryViewControllerDataSource.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "HistoryViewControllerDataSource.h"
#import "BookBoughtCell.h"
#import "PriceCell.h"
#import "DateHeaderTableView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Basket.h"
#import "Book.h"

static NSString * const bookBoughtIdentifier = @"BookBoughtCell";
static NSString * const priceIdentifier = @"PriceCell";


@implementation HistoryViewControllerDataSource

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headerHeight;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section andFrame:(CGRect)frame
{
    Basket *basket = self.baskets[section];
    
    return [[DateHeaderTableView alloc] initWithFrame:frame andBasket:basket];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.baskets.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *booksForBasket = self.basketsBooks[section];
    return booksForBasket.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSArray *booksForBasket = self.basketsBooks[indexPath.section];
    
    Basket *basket = self.baskets[indexPath.section];
    
    if (indexPath.row < booksForBasket.count)
    {
        BookBoughtCell *bookCell = [tableView dequeueReusableCellWithIdentifier:bookBoughtIdentifier forIndexPath:indexPath];
        
        Book *book = booksForBasket[indexPath.row];
        [bookCell setupForBook:[self dictionaryFromBook:book]];
        
        cell = bookCell;
    }
    
    else if (indexPath.row == booksForBasket.count)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        [priceCell setupForPrice:[basket.basicPrice floatValue] andTitle:NSLocalizedString(@"TOTAL", nil)];
        
        cell = priceCell;
    }
    
    else if (indexPath.row == booksForBasket.count + 1)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        [priceCell setupForPrice:[basket.bestPrice floatValue] andTitle:NSLocalizedString(@"TOTAL AFTER OFFER", nil)];
        
        cell = priceCell;
    }
    
    return cell;
}

- (NSDictionary*)dictionaryFromBook:(Book*)book
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    dic[@"cover"] = book.cover;
    dic[@"title"] = book.title;
    dic[@"price"] = book.price;
    
    return dic;
}


@end
