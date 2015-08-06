//
//  BooksViewControllerDataSource.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BooksViewControllerDataSource : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>

/**
 *  All the books to show
 */
@property (nonatomic, strong) NSArray *books;

/**
 *  All the books selected
 */
@property (nonatomic, strong) NSMutableSet *booksSelected;


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
