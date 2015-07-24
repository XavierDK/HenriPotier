//
//  Book.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 23/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

/**
 *  The entity containing data for a specific book saved locally
 */
@interface Book : NSManagedObject

/**
 *  The price of the books
 */
@property (nonatomic, retain) NSString * price;

/**
 *  The title of the book
 */
@property (nonatomic, retain) NSString * title;

/**
 *  The unique string identifier of the book
 */
@property (nonatomic, retain) NSString * isbn;

/**
 *  The image cover of the book
 */
@property (nonatomic, retain) NSString * cover;

/**
 *  The reference basket of the book
 */
@property (nonatomic, retain) NSManagedObject *basket;

@end
