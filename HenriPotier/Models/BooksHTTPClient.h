//
//  BooksHTTPClient.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

static NSString * const BooksURLString = @"http://henri-potier.xebia.fr/books";

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
