//
//  BooksHTTPClient.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>


@protocol BooksHTTPClientDelegate;


@interface BooksHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<BooksHTTPClientDelegate>delegate;

+ (BooksHTTPClient*)sharedBooksHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)updateBooks;
- (void)updateOffersForIsbns:(NSArray*)isbns;

- (CGFloat)totalPriceForBooks:(NSArray*)books;
- (CGFloat)bestPriceForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice;
- (NSArray*)pricesForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice;

@end


@protocol BooksHTTPClientDelegate <NSObject>

@optional

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithBooks:(NSArray*)books;
- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithOffers:(NSDictionary*)offers;
- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error;

@end
