//
//  ManagementTableViewCell.h
//  ChotaUdepur
//
//  Created by webmyne systems on 16/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ManagementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *imageviewManagement;
@property (weak, nonatomic) IBOutlet UILabel *lblManagementDesignation;
@property (weak, nonatomic) IBOutlet UILabel *lblManagementName;
@property (weak, nonatomic) IBOutlet UILabel *lblManagementEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblManagementOfficeNo;
@property (weak, nonatomic) IBOutlet UILabel *lblManagementMobileNo;

@property (weak, nonatomic) IBOutlet UILabel *lblJobNo;
@property (weak, nonatomic) IBOutlet UILabel *lblJobTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblJobDesciption;


@property (weak, nonatomic) IBOutlet UILabel *lblHelpline;
@property (weak, nonatomic) IBOutlet UIButton *btnCallHelpline;

@end
