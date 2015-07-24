//
//  BookBoughtCell.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 17/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The table cell for a book in a basket
 */
@interface BookBoughtCell : UITableViewCell

/**
 *  The image of a book
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

/**
 *  The title of a book
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  The price of a book
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
