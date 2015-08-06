//
//  BooksViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BooksViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "BooksHTTPClient.h"
#import <OpenSans/UIFont+OpenSans.h>
#import "BasketViewController.h"
#import "BooksViewControllerDataSource.h"


@interface BooksViewController () <BooksHTTPClientDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) BooksHTTPClient *booksClient;
@property (nonatomic, strong) BooksViewControllerDataSource *booksControllerDataSource;

@end


@implementation BooksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.booksControllerDataSource = [[BooksViewControllerDataSource alloc] init];
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Books are loading...", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    self.booksClient = [[BooksHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BooksURLString]];
    [self.booksClient setDelegate:self];
    [self.booksClient updateBooks];
    
    self.collectionView.alwaysBounceVertical = YES;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

- (void)startRefresh:(id)sender
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Books are loading...", nil) maskType:SVProgressHUDMaskTypeGradient];

    [self.booksClient updateBooks];
}


#pragma mark - Navigation

- (IBAction)confirmSelectionAction:(id)sender
{
    if (self.booksControllerDataSource.booksSelected.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Empty", nil) message:NSLocalizedString(@"You should select at least one book", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        [self performSegueWithIdentifier:@"BasketSegue" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BasketSegue"])
    {
        ((BasketViewController*)segue.destinationViewController).booksSelected = [self.booksControllerDataSource.booksSelected allObjects];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    self.booksControllerDataSource.books = self.books;
    return [self.booksControllerDataSource numberOfSectionsInCollectionView:collectionView];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [self.booksControllerDataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.booksControllerDataSource collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.booksControllerDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.booksControllerDataSource collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return [self.booksControllerDataSource collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}


#pragma mark <BooksHTTPClientDelegate>

-(void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithBooks:(NSArray*)books
{
    [SVProgressHUD dismiss];
    
    if ([self.refreshControl isRefreshing])
        [self.refreshControl endRefreshing];
    
    self.books = books;
    
    [self.collectionView reloadData];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    
    if ([self.refreshControl isRefreshing])
        [self.refreshControl endRefreshing];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"An error appeared.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}

@end
