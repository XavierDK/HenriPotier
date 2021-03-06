//
//  BookCell.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The Collection Cell for a book
 */
@interface BookCell : UICollectionViewCell

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
