//
//  InfosViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 22/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "InfosViewController.h"
#import "BooksHTTPClient.h"
#import "OfferCell.h"

@interface InfosViewController ()

@property (nonatomic, strong) NSArray *prices;

@end

@implementation InfosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.prices = [[BooksHTTPClient sharedBooksHTTPClient] pricesForOffers:self.offers andBasicPrice:self.basicPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.prices.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferCell"];
    
    cell.offerType.text = [NSString stringWithFormat:@"Type : %@", [NSLocalizedString(self.offers[@"offers"][indexPath.row][@"type"], nil) uppercaseString]];
    
    
    if ([self.offers[@"offers"][indexPath.row][@"type"] isEqualToString:@"percentage"])
    {
        cell.offerValue.text = [NSString stringWithFormat:NSLocalizedString(@"Value: %@%%", nil), self.offers[@"offers"][indexPath.row][@"value"]];
    }
    else if ([self.offers[@"offers"][indexPath.row][@"type"] isEqualToString:@"minus"])
    {
        cell.offerValue.text = [NSString stringWithFormat:NSLocalizedString(@"Value: %@€", nil), self.offers[@"offers"][indexPath.row][@"value"]];
    }
    else if ([self.offers[@"offers"][indexPath.row][@"type"] isEqualToString:@"slice"])
    {
        cell.offerValue.text = [NSString stringWithFormat:NSLocalizedString(@"SliceValue: %@€, Value: %@€", nil), self.offers[@"offers"][indexPath.row][@"sliceValue"], self.offers[@"offers"][indexPath.row][@"value"]];
    }
    
    cell.offerResult.text = [NSString stringWithFormat:NSLocalizedString(@"Result price : %.2f€", nil), [self.prices[indexPath.row] floatValue]];
    
    return cell;
}

@end
