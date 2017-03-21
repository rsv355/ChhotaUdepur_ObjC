//
//  TenderViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "TenderViewController.h"
#import "TenderTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"
#import "TenderDescriptionViewController.h"

@interface TenderViewController ()
{
    TenderTableViewCell *cell;
    NSArray *dataArr;

}
@end

@implementation TenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblCount setText:@""];
    [self fetchTenderDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView Datasource and Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=(TenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.lblSerialNo setText:[NSString stringWithFormat:@"Sreial No : %ld",indexPath.row+1]];
     [cell.lblTenderNo setText:[NSString stringWithFormat:@"Tender No : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"TenderNo"]]];
    [cell.lblStartDate setText:[NSString stringWithFormat:@"Start Date : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"StartDate"]]];
    [cell.lblEndDate setText:[NSString stringWithFormat:@"End Date : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"EndDate"]]];
    [cell.lblParticular setText:[NSString stringWithFormat:@"Particulars : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Description"]]];
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TenderDescriptionViewController *viewController =[self.storyboard instantiateViewControllerWithIdentifier:@"TENDER_DESCRIPTION"];
    viewController.strDescription=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Description"];
    viewController.strNoticeNo=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"TenderNo"];
    viewController.strNoticeDate=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"StartDate"];
    viewController.strSubmissionDate=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"EndDate"];
    viewController.strModeOfSubmission=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ModeOfSubmission"];
    viewController.strAttachment=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Attachment"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}
#pragma mark - Consume Web service methods

-(void) fetchTenderDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,TENDER_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,TENDER_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self fetchDataResponse:dataDict];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Chhota Udepur" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
    
}
-(void)fetchDataResponse:(NSDictionary *)dictionary{
    
    dataArr=[dictionary valueForKey:@"TenderResult"];
    [self.tableView reloadData];
    if ([dataArr count]==1||[dataArr count]==0) {
        [self.lblCount setText:[NSString stringWithFormat:@"%ld RECORD FOUND",[dataArr count]]];
    }
    else{
        [self.lblCount setText:[NSString stringWithFormat:@"%ld RECORDS FOUND",[dataArr count]]];
    }
}

@end
