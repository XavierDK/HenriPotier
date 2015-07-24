//
//  Basket.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 23/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class Book;

/**
 *  The entity containing data for a specific basket saved locally
 */
@interface Basket : NSManagedObject

/**
 *  The price for a basket befor an offer
 */
@property (nonatomic, retain) NSNumber * basicPrice;

/**
 *  The price for a basket after the best offer
 */
@property (nonatomic, retain) NSNumber * bestPrice;

/**
 *  All the books in the basket
 */
@property (nonatomic, retain) NSSet *books;

/**
 *  The date when the basket was submitted
 */
@property (nonatomic, retain) NSDate *date;

@end

@interface Basket (CoreDataGeneratedAccessors)

- (void)addBooksObject:(Book *)value;
- (void)removeBooksObject:(Book *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
