//
//  ComplainViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 27/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "ComplainViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"

@interface ComplainViewController ()

@end

@implementation ComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblComplainStatusHeightConst setConstant:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)btnRegisterNewComplaint:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"COMPLAINS_FORM"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnClear:(id)sender {
    [self.view endEditing:YES];
    [self.lblComplainStatusHeightConst setConstant:0.0];
    [self.txtCompaintNumber setText:@""];
}

- (IBAction)btnCheckStatus:(id)sender {
    [self.view endEditing:YES];
    if ([self.txtCompaintNumber.text length]==0) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter complaint number" delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   // NSLog(@"FETCHURL :%@%@",BASE_URL,FETCH_COMPLAINT_STATUS_URL);

    [manager GET:[NSString stringWithFormat:@"%@%@%@",BASE_URL,FETCH_COMPLAINT_STATUS_URL,[self.txtCompaintNumber text]]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"------dataDict---%@",dataDict);
        [self.lblComplainStatusHeightConst setConstant:30.0];
        [self.lblcomplaintStatus setText:[[dataDict objectForKey:@"ComplainStatusResult"] valueForKey:@"Status"]];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Chhota Udepur" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    }
}
@end
