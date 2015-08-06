//
//  BooksManager.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BooksManager : NSObject

/**
 *  Method to get the total price for some books
 *
 *  @param books The books for the price addition
 *
 *  @return The total price
 */
+ (CGFloat)totalPriceForBooks:(NSArray*)books;

/**
 *  Method to get the best price in different offers with a basic price
 *
 *  @param offersDic  The dictionary containing the offers available
 *  @param basicPrice The basic price of the addition of books
 *
 *  @return The best price found
 */
+ (CGFloat)bestPriceForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice;

/**
 *  Method to get the best prices for different offers
 *
 *  @param offersDic  offers dictionnary
 *  @param basicPrice basic price of the books
 *
 *  @return all the prices after offers calculated
 */
+ (NSArray*)pricesForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice;

@end
