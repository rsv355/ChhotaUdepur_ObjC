//
//  HomeCollectionViewCell.h
//  ChotaUdepur
//
//  Created by webmyne systems on 12/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;


@property (weak, nonatomic) IBOutlet UIImageView *imageViewTourist;
@property (weak, nonatomic) IBOutlet UIButton *btnMoreHelpline;

@end
