//
//  HelplineViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "HelplineViewController.h"
#import "ManagementTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"

@interface HelplineViewController ()
{
    ManagementTableViewCell *cell;
    NSArray *dataArr;
}
@end

@implementation HelplineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchHelplineDetails];
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
    cell.lblHelpline.text=[NSString stringWithFormat:@"%@ : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Name"],[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ContactNo"]];
    
    cell.btnCallHelpline.tag=indexPath.row;
    [cell.btnCallHelpline addTarget:self
                       action:@selector(btnCallHelpline:) forControlEvents:UIControlEventTouchDown];
    return  cell;
}

-(void)btnCallHelpline:(UIButton*)sender{
    
    NSString *phoneNumber = [NSString stringWithFormat:@"telprompt://%@",[[dataArr objectAtIndex:sender.tag]valueForKey:@"ContactNo"] ];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]) {
        
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Consume Web service methods

-(void) fetchHelplineDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,HELPLINE_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,HELPLINE_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    dataArr=[dictionary valueForKey:@"HelpLineResult"];
    [self.tableVIew reloadData];
}
@end
