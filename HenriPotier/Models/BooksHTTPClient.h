//
//  BooksHTTPClient.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>


@protocol BooksHTTPClientDelegate;

/**
 *  HTTP Client and Manager for the books and offers
 */
@interface BooksHTTPClient : AFHTTPSessionManager

/**
 *  The delegate for the client
 */
@property (nonatomic, weak) id<BooksHTTPClientDelegate>delegate;


/**
 *  Method the singleton of the Client
 *
 *  @return The singleton of the class
 */
+ (BooksHTTPClient*)sharedBooksHTTPClient;

/**
 *  Constructor of the class
 *
 *  @param url Basic URL of the books API
 *
 *  @return An instance of the class
 */
- (instancetype)initWithBaseURL:(NSURL *)url;

/**
 *  Method to download all the books available
 */
- (void)updateBooks;

/**
 *  Method to get all offers available for specifics books
 *
 *  @param isbns An array of the unique identifier of the books
 */
- (void)updateOffersForIsbns:(NSArray*)isbns;

/**
 *  Method to get the total price for some books
 *
 *  @param books The books for the price addition
 *
 *  @return The total price
 */
- (CGFloat)totalPriceForBooks:(NSArray*)books;

/**
 *  Method to get the best price in different offers with a basic price
 *
 *  @param offersDic  The dictionary containing the offers available
 *  @param basicPrice The basic price of the addition of books
 *
 *  @return The best price found
 */
- (CGFloat)bestPriceForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice;

/**
 *  <#Description#>
 *
 *  @param offersDic  <#offersDic description#>
 *  @param basicPrice <#basicPrice description#>
 *
 *  @return <#return value description#>
 */
- (NSArray*)pricesForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice;

@end


/**
 *  Interface of delegation of the Books HTTP Client
 */
@protocol BooksHTTPClientDelegate <NSObject>

@optional

/**
 *  Callback called when the request of book's recovery succeed
 *
 *  @param client The Book HTTP Client
 *  @param books  The Books recoveried
 */
- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithBooks:(NSArray*)books;

/**
 *  Callback called when the request of offers's recovery succeed
 *
 *  @param client The Book HTTP Client
 *  @param offers The offers recoveried
 */
- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithOffers:(NSDictionary*)offers;

/**
 *  Callback called when one of the requests failed
 *
 *  @param client The Book HTTP Client
 *  @param error The error of the request
 */
- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error;

@end
