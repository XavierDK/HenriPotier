//
//  HeaderTutorialReusableView.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 20/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The tutorial view to show how to selects books
 */
@interface HeaderTutorialReusableView : UICollectionReusableView

/**
 *  The title of the view
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

/**
 *  The tutorial description
 */
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end
