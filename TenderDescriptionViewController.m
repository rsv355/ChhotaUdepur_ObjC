//
//  TenderDescriptionViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "TenderDescriptionViewController.h"
#import "TenderTableViewCell.h"

@interface TenderDescriptionViewController ()
{
    TenderTableViewCell *cell;
    UIDocumentInteractionController *documentInteractionController;
}
@end

@implementation TenderDescriptionViewController
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setHidden:NO];
    [self.btnClosePDF setHidden:YES];
    // Do any additional setup after loading the view.
    if (_strAttachment.length==0) {
        [self.btnDownload setHidden:YES];
    }
    else{
        [self.btnDownload setHidden:NO];
    }
    [self.tableViewHeightConst setConstant:46*6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView Datasource and Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=(TenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (indexPath.row==0) {
        [cell.lblTenderDetails setText:[NSString stringWithFormat:@"Description : %@",_strDescription]];
    }
    else if (indexPath.row==1) {
        [cell.lblTenderDetails setText:[NSString stringWithFormat:@"Tender Notice No : %@",_strNoticeNo]];
    }
    else if (indexPath.row==2) {
        [cell.lblTenderDetails setText:[NSString stringWithFormat:@"Tender Notice Date : %@",_strNoticeDate]];
    }
    else if (indexPath.row==3) {
        [cell.lblTenderDetails setText:[NSString stringWithFormat:@"Available From : %@ TO %@",_strNoticeDate,_strSubmissionDate]];
    }
    else if (indexPath.row==4) {
        [cell.lblTenderDetails setText:[NSString stringWithFormat:@"Submission Date : %@",_strSubmissionDate]];
    }
    else if (indexPath.row==5) {
        [cell.lblTenderDetails setText:[NSString stringWithFormat:@"Mode of Submission : %@",_strModeOfSubmission]];
    }
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}
- (IBAction)btnDownload:(id)sender {

    [self.webView setHidden:NO];
     [self.btnClosePDF setHidden:NO];
    NSURL *targetURL = [NSURL URLWithString:@"http://www.tutorialspoint.com/objective_c/objective_c_tutorial.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    
//      NSURL *url = [[NSBundle mainBundle] URLForResource:@"ProgrammingGuide" withExtension:@"pdf"];
//    
//    if (url) {
//        documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
//        
//        [documentInteractionController setDelegate:self];
//        
//        [documentInteractionController presentPreviewAnimated:YES];
//    }

}
#pragma - Mark : Delegate for ui document interaction
-(UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (IBAction)btnClosePDF:(id)sender {
    [webView setHidden:YES];
     [self.btnClosePDF setHidden:YES];
}
@end
