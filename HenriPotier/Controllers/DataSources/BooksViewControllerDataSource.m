//
//  BooksViewControllerDataSource.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BooksViewControllerDataSource.h"
#import "BookCell.h"
#import "BookSelectedCell.h"
#import "HeaderTutorialReusableView.h"


static NSString * const reuseBookIdentifier = @"BookCell";
static NSString * const reuseBookSelectedIdentifier = @"BookSelectedCell";
static NSString * const reuseSectionHeaderIdentifier = @"HeaderView";

@implementation BooksViewControllerDataSource

- (id)init
{
    if (self = [super init])
    {
        self.booksSelected = [NSMutableSet set];
    }
    return self;
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
        HeaderTutorialReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseSectionHeaderIdentifier forIndexPath:indexPath];
                
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
    UICollectionViewCell *cell = nil;
    
    if ([self.booksSelected containsObject:self.books[indexPath.row]])
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseBookSelectedIdentifier forIndexPath:indexPath];
        [((BookSelectedCell*)cell) setupForBook:self.books[indexPath.row]];
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseBookIdentifier forIndexPath:indexPath];
        [((BookCell*)cell) setupForBook:self.books[indexPath.row]];
    }
    
    return cell;
}


#pragma mark <UICollectionViewLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.bounds.size.width - 3 * 10) / 2;
    CGFloat height = width * 1.5f;
    return CGSizeMake(width, height);
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.booksSelected containsObject:self.books[indexPath.row]])
        [self.booksSelected removeObject:self.books[indexPath.row]];
    else
        [self.booksSelected addObject:self.books[indexPath.row]];    
}


@end
