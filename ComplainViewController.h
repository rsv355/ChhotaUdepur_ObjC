//
//  ComplainViewController.h
//  ChotaUdepur
//
//  Created by webmyne systems on 27/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtCompaintNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterNewComplain;
- (IBAction)btnRegisterNewComplaint:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lblcomplaintStatus;
- (IBAction)btnClear:(id)sender;
- (IBAction)btnCheckStatus:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblComplainStatusHeightConst;

@end
