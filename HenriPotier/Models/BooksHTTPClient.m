//
//  BooksHTTPClient.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BooksHTTPClient.h"


static NSString * const BooksURLString = @"http://henri-potier.xebia.fr/books";
typedef CGFloat (^OfferType)(NSDictionary*, CGFloat);

@implementation BooksHTTPClient

+ (BooksHTTPClient*)sharedBooksHTTPClient
{
    static BooksHTTPClient *_sharedBooksHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedBooksHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BooksURLString]];
    });
    
    return _sharedBooksHTTPClient;
}

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
            else
                NSLog(@"Books should be an array.");
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

    BOOL firstTurn = TRUE;
    for (NSString *isbn in isbns)
    {
        if (!firstTurn)
            isbnsStr = [isbnsStr stringByAppendingString:@","];
        isbnsStr = [isbnsStr stringByAppendingString:isbn];
        
        firstTurn = FALSE;
    }
    
    [self GET:[NSString stringWithFormat:@"%@/commercialOffers", isbnsStr] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didUpdateWithOffers:)]) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]])
                [self.delegate booksHTTPClient:self didUpdateWithOffers:responseObject];
            else
                NSLog(@"Offers should be a dictionary.");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didFailWithError:)]) {
            [self.delegate booksHTTPClient:self didFailWithError:error];
        }
    }];
}

- (CGFloat)totalPriceForBooks:(NSArray*)books
{
    CGFloat totalPrice = 0.f;
    for (NSDictionary *book in books) {
        totalPrice += [book[@"price"] floatValue];
    }
    
    return totalPrice;
}

- (CGFloat)bestPriceForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice
{
    NSLog(@"Basic price : %f", basicPrice);
    
    NSDictionary *types = [self generateOffersTypeDictionary];
    
    NSArray *offers = offersDic[@"offers"];
    
    CGFloat bestPrice = basicPrice;
    NSInteger i = 0;
    for (NSDictionary *offer in offers)
    {
        for (NSString *type in types)
        {
            if ([type isEqualToString:offer[@"type"]])
            {
                OfferType offerBlock = types[type];
                CGFloat price = offerBlock(offer, basicPrice);
                
                NSLog(@"Price : %f", price);
                
                if (price < bestPrice)
                    bestPrice = price;
            }
            ++i;
        }
    }
    
    return bestPrice;
}

- (NSArray*)pricesForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *types = [self generateOffersTypeDictionary];
    
    NSArray *offers = offersDic[@"offers"];
    
    NSInteger i = 0;
    for (NSDictionary *offer in offers)
    {
        for (NSString *type in types)
        {
            if ([type isEqualToString:offer[@"type"]])
            {
                OfferType offerBlock = types[type];
                CGFloat price = offerBlock(offer, basicPrice);
                
                NSLog(@"Price : %f", price);
                
                [array addObject:@(price)];
            }
            ++i;
        }
    }
    
    return array;
}

- (NSDictionary*)generateOffersTypeDictionary
{
    OfferType percentageType = ^(NSDictionary *offer, CGFloat basicPrice){
        
        CGFloat percent = [offer[@"value"] floatValue];
        CGFloat price = basicPrice - (basicPrice * percent / 100);
        return price;
    };
    
    OfferType minusType = ^(NSDictionary *offer, CGFloat basicPrice){
        
        CGFloat minus = [offer[@"value"] floatValue];
        CGFloat price = basicPrice - minus;
        return price;
    };
    
    OfferType sliceType = ^(NSDictionary *offer, CGFloat basicPrice){
        
        CGFloat sliceValue = [offer[@"sliceValue"] floatValue];
        CGFloat slice = [offer[@"value"] floatValue];
        CGFloat price = basicPrice - ((NSInteger)(basicPrice / sliceValue)) * slice;
        return price;
    };
    
    
    NSDictionary *types = @{@"percentage":[percentageType copy],
                            @"minus":[minusType copy],
                            @"slice":[sliceType copy]};
    
    return types;
}


@end
