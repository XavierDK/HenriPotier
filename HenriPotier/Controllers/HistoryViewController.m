//
//  HistoryViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 23/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "HistoryViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <OpenSans/UIFont+OpenSans.h>
#import "Basket.h"
#import "Book.h"
#import "BookBoughtCell.h"
#import "PriceCell.h"


static NSString * const bookBoughtIdentifier = @"BookBoughtCell";
static NSString * const priceIdentifier = @"PriceCell";

@interface HistoryViewController ()

@end


@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.baskets = [[[Basket MR_findAll] reverseObjectEnumerator] allObjects];
    self.basketsBooks = [NSMutableArray array];
    for (Basket *basket in self.baskets) {
        
        NSArray *books = basket.books.allObjects;
        [self.basketsBooks addObject:books];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25.f)];
    
    [v setBackgroundColor:[UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f]];
    
    UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 10*2, 25.f)];
    [dateLbl setFont:[UIFont openSansSemiBoldFontOfSize:18.f]];
    [dateLbl setTextColor:[UIColor whiteColor]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    Basket *basket = self.baskets[section];
    dateLbl.text = [df stringFromDate:basket.date];
    [v addSubview:dateLbl];
    
    return v;
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
        
        [bookCell.imgView setImageWithURL:[NSURL URLWithString:book.cover]];
        bookCell.titleLabel.text = book.title;
        bookCell.priceLabel.text = [NSString stringWithFormat:@"%@ €", book.price];
        
        cell = bookCell;
    }
    
    else if (indexPath.row == booksForBasket.count)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        priceCell.titleLabel.text = NSLocalizedString(@"TOTAL", nil);
        priceCell.priceLabel.text = [NSString stringWithFormat:@"%.2f €", [basket.basicPrice floatValue]];
        
        cell = priceCell;
    }
    
    else if (indexPath.row == booksForBasket.count + 1)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        priceCell.titleLabel.text = NSLocalizedString(@"TOTAL AFTER OFFER", nil);
        priceCell.priceLabel.text = [NSString stringWithFormat:@"%.2f €", [basket.bestPrice floatValue]];
        
        cell = priceCell;
    }
    
    return cell;
}

@end
