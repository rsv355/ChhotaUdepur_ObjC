//
//  HomeViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 12/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import <sys/utsname.h>
#import "AppDelegate.h"

@interface HomeViewController ()
{
    HomeCollectionViewCell *cell;
    NSArray *iconArr,*titleArr,*colorArr,*storyboardIdArr;
    NSString *deviceName;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArr=[[NSArray alloc]initWithObjects:@"ABOUT US",@"MANAGEMENT",@"COMPLAINS",@"ACHIEVEMENT",@"JOBS",@"TOURIST SPOTS",@"HELPINES",@"TENDERS", nil];
    iconArr=[[NSArray alloc]initWithObjects:@"aboutus.png",@"management.png",@"complains.png",@"acheivments.png",@"jobs.png",@"tourists.png",@"helpline.png",@"tender.png", nil];
    
    UIColor *color1=[UIColor colorWithRed:(233/255.0) green:(30/255.0) blue:(99/255.0) alpha:1.0];
    UIColor *color2=[UIColor colorWithRed:(255/255.0) green:(193/255.0) blue:(7/255.0) alpha:1.0];
    UIColor *color3=[UIColor colorWithRed:(33/255.0) green:(150/255.0) blue:(243/255.0) alpha:1.0];
    UIColor *color4=[UIColor colorWithRed:(229/255.0) green:(57/255.0) blue:(53/255.0) alpha:1.0];
    UIColor *color5=[UIColor colorWithRed:(46/255.0) green:(125/255.0) blue:(50/255.0) alpha:1.0];
    UIColor *color6=[UIColor colorWithRed:(74/255.0) green:(20/255.0) blue:(140/255.0) alpha:1.0];
    UIColor *color7=[UIColor colorWithRed:(213/255.0) green:(0/255.0) blue:(249/255.0) alpha:1.0];
    UIColor *color8=[UIColor colorWithRed:(245/255.0) green:(124/255.0) blue:(0/255.0) alpha:1.0];
    
    colorArr=[[NSArray alloc]initWithObjects:color1,color2,color3,color4,color5,color6,color7,color8, nil];
    
    storyboardIdArr=[[NSArray alloc]initWithObjects:@"ABOUT_US",@"MANAGEMENT",@"COMPLAINS",@"ACHIEVEMENT",@"JOBS",@"TOURISTS",@"HELPLINE",@"TENDER", nil];
    
    NSNumber *value=[[NSUserDefaults standardUserDefaults]objectForKey:@"register"];
    NSNumber *value1=[[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"];
   // NSLog(@"------ %@",value1);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"register"] isEqualToString:@"0"]||value==nil) {
        if (value1 != nil) {
            
            [self registerDevice];
            
        }
        else {
           
        }
           }
    else{
             }
    //NSLog(@"TOKEN----%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"]);
  
  }
-(void)registerDevice{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"iPhone Simulator",
      @"x86_64":   @"iPad Simulator",
      
      @"iPhone1,1":    @"iPhone",
      @"iPhone1,2":    @"iPhone 3G",
      @"iPhone2,1":    @"iPhone 3GS",
      @"iPhone3,1":    @"iPhone 4",
      @"iPhone3,2":    @"iPhone 4(Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      @"iPhone4,1":    @"iPhone 4S",
      @"iPhone5,1":    @"iPhone 5(GSM)",
      @"iPhone5,2":    @"iPhone 5(GSM+CDMA)",
      @"iPhone5,3":    @"iPhone 5c(GSM)",
      @"iPhone5,4":    @"iPhone 5c(GSM+CDMA)",
      @"iPhone6,1":    @"iPhone 5s(GSM)",
      @"iPhone6,2":    @"iPhone 5s(GSM+CDMA)",
      
      @"iPhone7,1":    @"iPhone 6+ (GSM+CDMA)",
      @"iPhone7,2":    @"iPhone 6 (GSM+CDMA)",
      
      @"iPhone8,1":    @"iPhone 6S (GSM+CDMA)",
      @"iPhone8,2":    @"iPhone 6S+ (GSM+CDMA)",
      
      @"iPad1,1":  @"iPad",
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPad Mini 1G (WiFi)",
      @"iPad2,6":  @"iPad Mini 1G (GSM)",
      @"iPad2,7":  @"iPad Mini 1G (GSM+CDMA)",
      @"iPad3,1":  @"iPad 3(WiFi)",
      @"iPad3,2":  @"iPad 3(GSM+CDMA)",
      @"iPad3,3":  @"iPad 3(GSM)",
      @"iPad3,4":  @"iPad 4(WiFi)",
      @"iPad3,5":  @"iPad 4(GSM)",
      @"iPad3,6":  @"iPad 4(GSM+CDMA)",
      
      @"iPad4,1":  @"iPad Air(WiFi)",
      @"iPad4,2":  @"iPad Air(GSM)",
      @"iPad4,3":  @"iPad Air(GSM+CDMA)",
      
      @"iPad5,3":  @"iPad Air 2 (WiFi)",
      @"iPad5,4":  @"iPad Air 2 (GSM+CDMA)",
      
      @"iPad4,4":  @"iPad Mini 2G (WiFi)",
      @"iPad4,5":  @"iPad Mini 2G (GSM)",
      @"iPad4,6":  @"iPad Mini 2G (GSM+CDMA)",
      
      @"iPad4,7":  @"iPad Mini 3G (WiFi)",
      @"iPad4,8":  @"iPad Mini 3G (GSM)",
      @"iPad4,9":  @"iPad Mini 3G (GSM+CDMA)",
      
      @"iPod1,1":  @"iPod 1st Gen",
      @"iPod2,1":  @"iPod 2nd Gen",
      @"iPod3,1":  @"iPod 3rd Gen",
      @"iPod4,1":  @"iPod 4th Gen",
      @"iPod5,1":  @"iPod 5th Gen",
      @"iPod7,1":  @"iPod 6th Gen",
      };
    deviceName = commonNamesDictionary[machineName];
   
    NSString* uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+

    NSString *deviceToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
       //using post
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            uniqueIdentifier,@"DeviceID",
                            deviceName,@"DeviceModel",
                           deviceToken,@"DeviceToken",
                            @"I",@"DeviceType",
                           nil];
     manager.requestSerializer = [AFJSONRequestSerializer serializer]; // if request JSON format
    [manager POST:@"http://www.aapnuchhotaudepur.com/CUSevaSadan_WS/Service.svc/json/RegisterDevice" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"RESPONSE: %@", responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        NSDictionary *dataDict = responseObject;
        //NSLog(@"dic1 : %@",dataDict);
        [self fetchDataResponse:dataDict];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       //NSLog(@"ERROR: %@", error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
 }
-(void)fetchDataResponse:(NSDictionary *)dictionary{
   // NSLog(@"----%@",[[dictionary valueForKey:@"RegisterDeviceResult"] valueForKey:@"ResponseCode"]);
    if ([[[dictionary valueForKey:@"RegisterDeviceResult"] valueForKey:@"ResponseCode"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"register"];
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"register"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource and Delegate method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [titleArr count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.lblTitle.text=[titleArr objectAtIndex:indexPath.row];
    cell.iconImageView.image=[UIImage imageNamed:[iconArr objectAtIndex:indexPath.row]];
    cell.backgroundColor=[colorArr objectAtIndex:indexPath.row];
    cell.layer.cornerRadius=5.0f;
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
    //NSLog(@"-->>%@",[storyboardIdArr objectAtIndex:indexPath.row]);
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:[storyboardIdArr objectAtIndex:indexPath.row]];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma - mark UIButton IBAction

- (IBAction)btnNews:(id)sender {
    UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NEWS"];
    [self presentViewController:viewController animated:YES completion:nil];
}


-(void)pushNotificationData{
    
    
}
@end
