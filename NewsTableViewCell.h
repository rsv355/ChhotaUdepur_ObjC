//
//  NewsTableViewCell.h
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface NewsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet AsyncImageView *imageViewNews;
@property (weak, nonatomic) IBOutlet UILabel *lblbNewTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNewDecription;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAchievement;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleAchievement;
@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionAchievement;
@property (weak, nonatomic) IBOutlet UIButton *btnReadMore;
@property (weak, nonatomic) IBOutlet UILabel *lblAwardBy;
@property (weak, nonatomic) IBOutlet UILabel *lblAwardFrom;
@end
