//
//  HistoryViewControllerDataSource.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 05/08/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat const headerHeight = 25.f;

@interface HistoryViewControllerDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

/**
 *  Array of all the baskets
 */
@property (nonatomic, strong) NSArray *baskets;

/**
 *  Array of all the books for the baskets
 */
@property (nonatomic, strong) NSMutableArray *basketsBooks;

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section andFrame:(CGRect)frame;

@end
