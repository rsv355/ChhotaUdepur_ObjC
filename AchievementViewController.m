//
//  AchievementViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "AchievementViewController.h"
#import "NewsTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"

@interface AchievementViewController ()
{
    NewsTableViewCell *cell;
    NSArray *dataArr;
}
@end

@implementation AchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchAchievementDetails];
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
    cell=(NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.lblTitleAchievement.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Award"];
    cell.lblAwardBy.text=[NSString stringWithFormat:@"Award By : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"AwardBy"]];
    cell.lblAwardFrom.text=[NSString stringWithFormat:@"Award For : %@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"AwardFor"]];
    NSURL *url = [NSURL URLWithString:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.imageViewAchievement setImage:[[UIImage alloc]initWithData:data]];
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

-(void) fetchAchievementDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,ACHIVEMENT_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,ACHIVEMENT_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"--->>%@",dataDict);
        [self fetchDataResponse:dataDict];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Chhota Udepur" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
    
}
-(void)fetchDataResponse:(NSDictionary *)dictionary{
    
    dataArr=[dictionary valueForKey:@"AchievementResult"];
    [self.tableView reloadData];
}



@end
