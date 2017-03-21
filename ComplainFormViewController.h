//
//  ComplainFormViewController.h
//  ChotaUdepur
//
//  Created by webmyne systems on 27/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplainFormViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnComplainCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnComplainCategoryType;
@property (weak, nonatomic) IBOutlet UIButton *btWardNo;
- (IBAction)btnComplainCategory:(id)sender;
- (IBAction)btnComplainCategoryType:(id)sender;
- (IBAction)btWardNo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtDescribeComplaint;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UITextView *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPincode;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNO;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;

- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnUploadImage:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
