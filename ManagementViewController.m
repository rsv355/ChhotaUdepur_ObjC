//
//  ManagementViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 16/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "ManagementViewController.h"
#import "ManagementTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"

@interface ManagementViewController ()
{
    ManagementTableViewCell *cell;
    NSArray *dataArr;
}
@end

@implementation ManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchManagementDetails];
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
    cell=(ManagementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.lblManagementDesignation.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Designation"];
      //cell.imageviewManagement=(AsyncImageView *)[cell viewWithTag:10];
    
    NSURL *url = [NSURL URLWithString:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.imageviewManagement setImage:[[UIImage alloc]initWithData:data]];
    [cell.lblManagementName setText:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Name"]];
    [cell.lblManagementEmail setText:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Email"]];
    [cell.lblManagementOfficeNo setText:[@"Office : "stringByAppendingString:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"OfficeNo"]]];
    [cell.lblManagementMobileNo setText:[@"Mobile No : " stringByAppendingString:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"MobileNo"]]];
  
    return  cell;
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Consume Web service methods

-(void) fetchManagementDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,ABOUT_US_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,MANAGEMENT_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    dataArr=[dictionary valueForKey:@"ManagementResult"];
    [self.tableView reloadData];
}
@end
