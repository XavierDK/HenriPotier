//
//  BooksViewController.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  ViewController for the selection of the books
 */
@interface BooksViewController : UICollectionViewController

/**
 *  All the books to show
 */
@property (nonatomic, strong) NSArray *books;

@end
