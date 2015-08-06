//
//  BookSelectedCell.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  The collection cell for a book selected
 */
@interface BookSelectedCell : UICollectionViewCell

/**
 *  The cover of a book
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 *  The title of a book
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  The price of a book
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


/**
 *  Method to setup atrtibutes of the book cell
 *
 *  @param book The book disctionary
 */
- (void)setupForBook:(NSDictionary*)book;

@end