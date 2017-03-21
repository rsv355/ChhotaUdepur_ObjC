//
//  NewsViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"
#import "NewsReadMoreViewController.h"

@interface NewsViewController ()
{
    NewsTableViewCell *cell;
    NSArray *dataArr;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchNewsDetails];
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
    cell.lblbNewTitle.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Title"];
    cell.lblNewDecription.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Description"];
    NSURL *url = [NSURL URLWithString:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Attachment"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.imageViewNews setImage:[[UIImage alloc]initWithData:data]];
    [cell.btnReadMore setTag:indexPath.row];
    [cell.btnReadMore addTarget:self
                       action:@selector(btnReadMore:) forControlEvents:UIControlEventTouchDown];
    return  cell;
}

-(void)btnReadMore:(UIButton*)sender
{
    NewsReadMoreViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS_READ_MORE"];
    
    viewController.strDate=[[dataArr objectAtIndex:sender.tag]valueForKey:@"DateGenerated"];
    viewController.strNewsTitle=[[dataArr objectAtIndex:sender.tag]valueForKey:@"Title"];
    viewController.strDescription=[[dataArr objectAtIndex:sender.tag]valueForKey:@"Description"];
    viewController.imageURL=[[dataArr objectAtIndex:sender.tag]valueForKey:@"Attachment"];
    
    [self presentViewController:viewController animated:YES completion:nil];
}
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Consume Web service methods

-(void) fetchNewsDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   // NSLog(@"FETCHURL :%@%@",BASE_URL,NEWS_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,NEWS_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    dataArr=[dictionary valueForKey:@"FetchNewsResult"];
    [self.tableView reloadData];
}
@end
