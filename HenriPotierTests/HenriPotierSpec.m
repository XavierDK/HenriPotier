//
//  HenriPotierTests.m
//  HenriPotierTests
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "Kiwi.h"
#import "BooksManager.h"

SPEC_BEGIN(HenriPotierSpec)

NSArray *books = @[
                   @{
                       @"isbn": @"c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                       @"title": @"Henri Potier à l'école des sorciers",
                       @"price": @(35),
                       @"cover": @"http://henri-potier.xebia.fr/hp0.jpg"
                       },
                   @{
                       @"isbn": @"a460afed-e5e7-4e39-a39d-c885c05db861",
                       @"title": @"Henri Potier et la Chambre des secrets",
                       @"price": @(30),
                       @"cover": @"http://henri-potier.xebia.fr/hp1.jpg"
                       },
                   @{
                       @"isbn": @"fcd1e6fa-a63f-4f75-9da4-b560020b6acc",
                       @"title": @"Henri Potier et le Prisonnier d'Azkaban",
                       @"price": @(30),
                       @"cover": @"http://henri-potier.xebia.fr/hp2.jpg"
                       }];

NSDictionary *offers = @{
                         @"offers": @[
                                 @{
                                     @"type": @"percentage",
                                     @"value": @(4)
                                     },
                                 @{
                                     @"type": @"minus",
                                     @"value": @(15)
                                     },
                                 @{
                                     @"type": @"slice",
                                     @"sliceValue": @(80),
                                     @"value": @(14)
                                     }
                                 ]
                         };


describe(@"Books Manager", ^{
    
    context(@"when calculate the basic price for books above", ^{
        
        it(@"should equal 95", ^{
            [[theValue([BooksManager totalPriceForBooks:books]) should] equal:95 withDelta:0];
        });
    });
    
    context(@"when calculate price after percentage for books and offers above", ^{
        
        it(@"should equal 91.2", ^{
            
            [[theValue([[BooksManager pricesForOffers:offers andBasicPrice:[BooksManager totalPriceForBooks:books]][0] floatValue]) should] equal:91.2 withDelta:0.1];
        });
    });
    
    context(@"when calculate price after minus for books and offers above", ^{
        
        it(@"should equal 80", ^{
            
            [[theValue([[BooksManager pricesForOffers:offers andBasicPrice:[BooksManager totalPriceForBooks:books]][1] floatValue]) should] equal:80 withDelta:0.1];
        });
    });
    
    context(@"when calculate price after slice for books and offers above", ^{
        
        it(@"should equal 81", ^{
            
            [[theValue([[BooksManager pricesForOffers:offers andBasicPrice:[BooksManager totalPriceForBooks:books]][2] floatValue]) should] equal:81 withDelta:0.1];
        });
    });
    
    context(@"when calculate best price for books and offers above", ^{
        
        it(@"should equal 80", ^{
            
            [[theValue([BooksManager bestPriceForOffers:offers andBasicPrice:[BooksManager totalPriceForBooks:books]]) should] equal:80 withDelta:0.1];
        });
    });

});

SPEC_END