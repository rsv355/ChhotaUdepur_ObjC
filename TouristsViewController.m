//
//  TouristsViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "TouristsViewController.h"
#import "CustomAnimationAndTransiotion.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AppURL.h"

@interface TouristsViewController ()
{
    HomeCollectionViewCell *cell;
    NSArray *dataArr;
}
@property (nonatomic,strong) CustomAnimationAndTransiotion *customTransitionController;
@end

@implementation TouristsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchTouristDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource and Delegate method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [dataArr count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.imageViewTourist setImage:[[UIImage alloc]initWithData:data]];
    cell.btnMoreHelpline.tag=indexPath.row;
    [cell.btnMoreHelpline addTarget:self
                             action:@selector(btnMoreHelpline:) forControlEvents:UIControlEventTouchDown];
        return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double side1,side2;
    CGSize collectionviewSize=self.collectionView.frame.size;
    side1=collectionviewSize.width/2-15;
    side2=collectionviewSize.width/2-50;
    return CGSizeMake(side1, side2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    }

-(void)btnMoreHelpline:(UIButton*)sender{
    NSString *description=[[dataArr objectAtIndex:sender.tag]valueForKey:@"Description"];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:description delegate:(id)self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Consume Web service methods

-(void) fetchTouristDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,TOURIST_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,TOURIST_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    dataArr=[dictionary valueForKey:@"TouristResult"];
    [self.collectionView reloadData];
}

//
//    UIViewController *popover=[self.storyboard instantiateViewControllerWithIdentifier:@"TOURISTS_DIALOGUE"];
//    popover.modalPresentationStyle = UIModalPresentationCustom;
//    [popover setTransitioningDelegate:_customTransitionController];
//    [self presentViewController:popover animated:YES completion:nil];
@end
