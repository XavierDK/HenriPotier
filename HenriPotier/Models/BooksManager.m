//
//  BooksManager.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "BooksManager.h"

typedef CGFloat (^OfferType)(NSDictionary*, CGFloat);

@implementation BooksManager

+ (CGFloat)totalPriceForBooks:(NSArray*)books
{
    CGFloat totalPrice = 0.f;
    for (NSDictionary *book in books) {
        totalPrice += [book[@"price"] floatValue];
    }
    
    return totalPrice;
}

+ (CGFloat)bestPriceForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice
{
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
                
                if (price < bestPrice)
                    bestPrice = price;
            }
            ++i;
        }
    }
    
    return bestPrice;
}

+ (NSArray*)pricesForOffers:(NSDictionary*)offersDic andBasicPrice:(CGFloat)basicPrice
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
                [array addObject:@(price)];
            }
            ++i;
        }
    }
    
    return array;
}

+ (NSDictionary*)generateOffersTypeDictionary
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
