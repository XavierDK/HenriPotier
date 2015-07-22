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
    
    cell.offerType.text = [NSString stringWithFormat:@"Type : %@", [self.offers[@"offers"][indexPath.row][@"type"] uppercaseString]];
    
    cell.offerValue.text = [NSString stringWithFormat:@"Value : %@€", self.offers[@"offers"][indexPath.row][@"value"]];
    
    cell.offerResult.text = [NSString stringWithFormat:@"Result price : %@€", self.prices[indexPath.row]];
    
    return cell;
}

@end
