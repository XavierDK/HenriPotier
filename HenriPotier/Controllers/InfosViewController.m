//
//  InfosViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 22/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "InfosViewController.h"
#import "InfosViewControllerDataSource.h"
#import "BooksManager.h"

@interface InfosViewController ()

@property (nonatomic, strong) InfosViewControllerDataSource *infosControllerDataSource;

@end


@implementation InfosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infosControllerDataSource = [[InfosViewControllerDataSource alloc] init];
    self.infosControllerDataSource.offers = self.offers;
    self.infosControllerDataSource.prices = [BooksManager pricesForOffers:self.offers andBasicPrice:self.basicPrice];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.infosControllerDataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infosControllerDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.infosControllerDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

@end
