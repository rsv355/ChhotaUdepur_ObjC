//
//  JobViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "JobViewController.h"
#import "ManagementTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"

@interface JobViewController ()
{
    ManagementTableViewCell *cell;
    NSArray *dataArr;
}
@end

@implementation JobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchJobDetails];
    
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
    cell.lblJobNo.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.lblJobTitle.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Title"];
    cell.lblJobDesciption.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Description"];
    return  cell;
}

- (NSUInteger)numberOfWordsInString:(NSString *)str {
    __block NSUInteger count = 0;
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length])
                            options:NSStringEnumerationByWords|NSStringEnumerationSubstringNotRequired
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                             count++;
                         }];
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    if([self numberOfWordsInString:[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Description"]]>100){
        cellHeight=150;
    }
    else{
        cellHeight=80;
    }
    
    return cellHeight;
}
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}
#pragma mark - Consume Web service methods

-(void) fetchJobDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,CURRENTJOB_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,CURRENTJOB_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    dataArr=[dictionary valueForKey:@"FetchJobResult"];
    [self.tableView reloadData];
    if ([dataArr count]==1||[dataArr count]==0) {
         [self.lblTotalJob setText:[NSString stringWithFormat:@"%ld JOB FOUND",[dataArr count]]];
    }
    else{
         [self.lblTotalJob setText:[NSString stringWithFormat:@"%ld JOBS FOUND",[dataArr count]]];
    }
}

@end
