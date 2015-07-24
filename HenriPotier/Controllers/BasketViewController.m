//
//  BasketViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BasketViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <UIFont+OpenSans.h>
#import <MagicalRecord/MagicalRecord.h>
#import "BooksHTTPClient.h"
#import "BookBoughtCell.h"
#import "PriceCell.h"
#import "InfosViewController.h"
#import "Basket.h"
#import "Book.h"


@interface BasketViewController () <BooksHTTPClientDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *buyButton;

@end


@implementation BasketViewController

static NSString * const bookBoughtIdentifier = @"BookBoughtCell";
static NSString * const priceIdentifier = @"PriceCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.basicPrice = [[BooksHTTPClient sharedBooksHTTPClient] totalPriceForBooks:self.booksSelected];
    self.bestPrice = self.basicPrice;
    
    self.buyButton.titleLabel.font = [UIFont openSansBoldFontOfSize:18.f];
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Offers are loading...", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    NSMutableArray *isbns = [NSMutableArray array];
    for (NSDictionary *book in self.booksSelected)
    {
        [isbns addObject:book[@"isbn"]];
    }
    
    [[BooksHTTPClient sharedBooksHTTPClient] setDelegate:self];
    [[BooksHTTPClient sharedBooksHTTPClient] updateOffersForIsbns:isbns];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueInfos"])
    {
        ((InfosViewController*)segue.destinationViewController).offers = self.offers;
        ((InfosViewController*)segue.destinationViewController).basicPrice = self.basicPrice;
    }
}

- (IBAction)boughtPressed:(id)sender
{
    Basket *basket = [Basket MR_createEntity];
    
    basket.basicPrice = @(self.basicPrice);
    basket.bestPrice = @(self.bestPrice);
    basket.date = [NSDate date];
    
    for (NSDictionary *bookDic in self.booksSelected)
    {
        Book *book = [Book MR_createEntity];
        
        book.title = bookDic[@"title"];
        book.price = bookDic[@"price"];
        book.isbn = bookDic[@"isbn"];
        book.cover = bookDic[@"cover"];
        
        [basket addBooksObject:book];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Basket", nil) message:NSLocalizedString(@"Your basket has been saved!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
}


#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:TRUE] ;
    }
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
        
        [bookCell.imgView setImageWithURL:[NSURL URLWithString:self.booksSelected[indexPath.row][@"cover"]]];
        bookCell.titleLabel.text = self.booksSelected[indexPath.row][@"title"];
        bookCell.priceLabel.text = [NSString stringWithFormat:@"%@ €", self.booksSelected[indexPath.row][@"price"]];
        
        cell = bookCell;
    }
    
    else if (indexPath.row == self.booksSelected.count)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        priceCell.titleLabel.text = NSLocalizedString(@"TOTAL", nil);
        priceCell.priceLabel.text = [NSString stringWithFormat:@"%.2f €", self.basicPrice];
        
        cell = priceCell;
    }
    
    else if (indexPath.row == self.booksSelected.count + 1)
    {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:priceIdentifier forIndexPath:indexPath];
        
        priceCell.titleLabel.text = NSLocalizedString(@"TOTAL AFTER OFFER", nil);
        priceCell.priceLabel.text = [NSString stringWithFormat:@"%.2f €", self.bestPrice];
        
        cell = priceCell;
    }
    
    
    return cell;
}


#pragma mark <BooksHTTPClientDelegate>

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithOffers:(NSDictionary *)offers
{
    [SVProgressHUD dismiss];
    
    self.offers = offers;
    
    self.bestPrice = [[BooksHTTPClient sharedBooksHTTPClient] bestPriceForOffers:self.offers andBasicPrice:self.basicPrice];
    
    [self.tableView reloadData];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"An error appeared.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}

@end
