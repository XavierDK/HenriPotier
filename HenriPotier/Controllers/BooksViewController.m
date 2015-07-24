//
//  BooksViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BooksViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "BooksHTTPClient.h"
#import "BookCell.h"
#import "BasketViewController.h"
#import "HeaderTutorialReusableView.h"
#import <OpenSans/UIFont+OpenSans.h>


static NSString * const reuseIdentifier = @"BookCell";


@interface BooksViewController () <BooksHTTPClientDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end


@implementation BooksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.booksSelected = [NSMutableSet set];
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Books are loading...", nil) maskType:SVProgressHUDMaskTypeGradient];
    [[BooksHTTPClient sharedBooksHTTPClient] setDelegate:self];
    [[BooksHTTPClient sharedBooksHTTPClient] updateBooks];
    
    self.collectionView.alwaysBounceVertical = YES;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)startRefresh:(id)sender
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Books are loading...", nil) maskType:SVProgressHUDMaskTypeGradient];
    [[BooksHTTPClient sharedBooksHTTPClient] setDelegate:self];
    [[BooksHTTPClient sharedBooksHTTPClient] updateBooks];
}


#pragma mark - Navigation

- (IBAction)confirmSelectionAction:(id)sender
{
    if (self.booksSelected.count == 0)
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
        ((BasketViewController*)segue.destinationViewController).booksSelected = [self.booksSelected allObjects];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderTutorialReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        headerView.titleLabel.text = @"Henri Potier";
        headerView.descriptionLabel.text = NSLocalizedString(@"Click on the books that you want to buy and press the button confirm. You will discover our best offer!", nil);
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = nil;
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.books[indexPath.row][@"cover"]]];
    cell.titleLabel.text = self.books[indexPath.row][@"title"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@€", self.books[indexPath.row][@"price"]];
    
    if ([self.booksSelected containsObject:self.books[indexPath.row]])
    {
        [cell.selectionView setBackgroundColor:[UIColor blackColor]];
        cell.validatedImg.hidden = FALSE;
    }
    else
    {
        [cell.selectionView setBackgroundColor:[UIColor clearColor]];
        cell.validatedImg.hidden = TRUE;
    }
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.booksSelected containsObject:self.books[indexPath.row]])
        [self.booksSelected removeObject:self.books[indexPath.row]];
    else
        [self.booksSelected addObject:self.books[indexPath.row]];
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.collectionView.bounds.size.width - 3 * 10) / 2;
    CGFloat height = width * 1.5f;
    return CGSizeMake(width, height);
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

-(void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    
    if ([self.refreshControl isRefreshing])
        [self.refreshControl endRefreshing];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"An error appeared.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}

@end
