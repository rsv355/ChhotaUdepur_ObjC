//
//  NewsReadMoreViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 27/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "NewsReadMoreViewController.h"
#import "NSString+HTML.h"
#import "MBProgressHUD.h"

@interface NewsReadMoreViewController ()

@end

@implementation NewsReadMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.lblDate setText:_strDate];
    
    NSString *strTitle=[_strNewsTitle stringByDecodingHTMLEntities];
    [self.lblNewsTitle setText:strTitle];
    
     NSString *strDesc=[_strDescription stringByDecodingHTMLEntities];
    [self.lblNewsDescription setText:strDesc];

     [MBProgressHUD showHUDAddedTo:self.imageView animated:YES];
    NSURL *url = [NSURL URLWithString:_imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.imageView setImage:[[UIImage alloc]initWithData:data]];
    [MBProgressHUD hideAllHUDsForView:self.imageView animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnNews:(id)sender {
    UIViewController *viewCotroller=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewCotroller animated:YES completion:nil];
}

@end
