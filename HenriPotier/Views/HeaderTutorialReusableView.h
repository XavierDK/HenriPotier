//
//  HeaderTutorialReusableView.h
//  HenriPotier
//
//  Created by Xavier De Koninck on 20/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTutorialReusableView : UICollectionReusableView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end
