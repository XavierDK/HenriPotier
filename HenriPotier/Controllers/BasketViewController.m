//
//  BasketViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BasketViewController.h"
#import "BasketViewControllerDataSource.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <UIFont+OpenSans.h>
#import <MagicalRecord/MagicalRecord.h>
#import "BooksHTTPClient.h"
#import "BooksManager.h"
#import "InfosViewController.h"
#import "Basket.h"
#import "Book.h"


@interface BasketViewController () <BooksHTTPClientDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *buyButton;

@property (nonatomic, strong) BooksHTTPClient *booksClient;
@property (nonatomic, strong) BasketViewControllerDataSource *basketControllerDataSource;

@end


@implementation BasketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.buyButton.titleLabel.font = [UIFont openSansBoldFontOfSize:18.f];
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Offers are loading...", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    NSMutableArray *isbns = [NSMutableArray array];
    for (NSDictionary *book in self.booksSelected)
        [isbns addObject:book[@"isbn"]];
    
    self.booksClient = [[BooksHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BooksURLString]];
    [self.booksClient setDelegate:self];
    [self.booksClient updateOffersForIsbns:isbns];
    
    [self setupDataSource];
}

- (void)setupDataSource
{
    self.basketControllerDataSource = [[BasketViewControllerDataSource alloc] init];
    self.basketControllerDataSource.booksSelected = self.booksSelected;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueInfos"])
    {
        ((InfosViewController*)segue.destinationViewController).offers = self.basketControllerDataSource.offers;
        ((InfosViewController*)segue.destinationViewController).basicPrice = self.basketControllerDataSource.basicPrice;
    }
}

- (IBAction)boughtPressed:(id)sender
{
    Basket *basket = [Basket MR_createEntity];
    
    basket.basicPrice = @(self.basketControllerDataSource.basicPrice);
    basket.bestPrice = @(self.basketControllerDataSource.bestPrice);
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
        [self.navigationController popViewControllerAnimated:YES] ;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.basketControllerDataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.basketControllerDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.basketControllerDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark <BooksHTTPClientDelegate>

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithOffers:(NSDictionary *)offers
{
    [SVProgressHUD dismiss];
    
    self.basketControllerDataSource.offers = offers;
    
    [self.tableView reloadData];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"An error appeared.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}

@end
