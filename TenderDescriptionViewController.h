//
//  TenderDescriptionViewController.h
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TenderDescriptionViewController : UIViewController<UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) NSString *strDescription;
@property (strong, nonatomic) NSString *strNoticeNo;
@property (strong, nonatomic) NSString *strNoticeDate;
@property (strong, nonatomic) NSString *strAttachment;
@property (strong, nonatomic) NSString *strSubmissionDate;
@property (strong, nonatomic) NSString *strModeOfSubmission;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConst;

@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
- (IBAction)btnDownload:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)btnClosePDF:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnClosePDF;

@property (nonatomic, strong) UIDocumentInteractionController *controller;
@end
