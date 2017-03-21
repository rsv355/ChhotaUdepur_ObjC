//
//  AboutUsViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 16/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"
#import "NSString+HTML.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblAboutUs setText:@""
     ];
    [self fetchAboutUsDetails];
    //NSLog(@"TOKEN----%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Consume Web service methods
-(void) fetchAboutUsDetails
{

    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        //NSLog(@"FETCHURL :%@%@",BASE_URL,ABOUT_US_URL);
        
        [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,ABOUT_US_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            //NSLog(@"dic1 : %@",dataDict);
            
            [self fetchDataResponse:dataDict];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Chhota Udepur" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlert show];
        }];
        
   
}
-(void)fetchDataResponse:(NSDictionary *)dictionary{
    
    NSArray *dataArr=[dictionary valueForKey:@"AboutUSResult"];
    
    //NSString *htmlString=[[dataArr objectAtIndex:0] valueForKey:@"Description"];
    
    NSString *htmlString=[NSString stringWithFormat:@"<div style='text-align:justify; font-size:15px;font-family:Helvetica;color:#362932;'>%@",[[dataArr objectAtIndex:0] valueForKey:@"Description"]];
    
//    NSData *HTMLData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
//    NSString *plainString = attrString.string;
    NSString *str=[htmlString stringByDecodingHTMLEntities];
    [self.lblAboutUs setText:str
     ];

    NSURL *url = [NSURL URLWithString:[[dataArr objectAtIndex:0] valueForKey:@"Image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.imageAboutUs setImage:[[UIImage alloc]initWithData:data]];

}


@end
