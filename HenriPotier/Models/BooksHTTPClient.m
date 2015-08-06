//
//  BooksHTTPClient.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BooksHTTPClient.h"


@implementation BooksHTTPClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void)updateBooks
{
    [self GET:@"" parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didUpdateWithBooks:)]) {
            
            if ([responseObject isKindOfClass:[NSArray class]])
                [self.delegate booksHTTPClient:self didUpdateWithBooks:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didFailWithError:)]) {
            [self.delegate booksHTTPClient:self didFailWithError:error];
        }
    }];
}

- (void)updateOffersForIsbns:(NSArray*)isbns
{
    NSString *isbnsStr = [NSString string];
    
    BOOL firstTurn = YES;
    for (NSString *isbn in isbns)
    {
        if (!firstTurn)
            isbnsStr = [isbnsStr stringByAppendingString:@","];
        isbnsStr = [isbnsStr stringByAppendingString:isbn];
        
        firstTurn = NO;
    }
    
    [self GET:[NSString stringWithFormat:@"%@/commercialOffers", isbnsStr] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didUpdateWithOffers:)]) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]])
                [self.delegate booksHTTPClient:self didUpdateWithOffers:responseObject];

        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didFailWithError:)]) {
            [self.delegate booksHTTPClient:self didFailWithError:error];
        }
    }];
}

@end
