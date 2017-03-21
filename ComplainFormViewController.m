//
//  ComplainFormViewController.m
//  ChotaUdepur
//
//  Created by webmyne systems on 27/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "ComplainFormViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppURL.h"
#import "TenderTableViewCell.h"
#import "UITextView+Placeholder.h"

@interface ComplainFormViewController ()
{
    NSArray *dataArr,*categoryArr,*categoryTypeArr,*wardNoArr;
    NSDictionary *dataDict;
    NSInteger buttonStatus;
    TenderTableViewCell *cell;
    NSString *strCategory,*strCategoryType,*strWardNo;
}
@end

@implementation ComplainFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataDict=[[NSDictionary alloc]init];
    categoryArr=[[NSArray alloc]init];
    categoryTypeArr=[[NSArray alloc]init];
    wardNoArr=[[NSArray alloc]init];
    
    [self fetchComplainDetails];
    [self.tableView setHidden:YES];
    buttonStatus=0;
    [self.txtDescribeComplaint setPlaceholder:@"Describe Complaint"];
    [self.txtAddress setPlaceholder:@"Address"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect windowFrame = [self.view.window convertRect:self.view.frame fromView:self.view];
    CGRect keyboardFrame = CGRectIntersection (windowFrame, keyboardInfoFrame);
    CGRect coveredFrame = [self.view.window convertRect:keyboardFrame toView:self.view];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake (0.0, 0.0, coveredFrame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.frame.size.width, self.scrollView.contentSize.height)];
    
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}



- (IBAction)btnComplainCategory:(id)sende{
  
    buttonStatus=1;
    [self.tableView setHidden:NO];
    [self.tableView reloadData];
   
}

- (IBAction)btnComplainCategoryType:(id)sender {
//    if (strCategory.length==0) {
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Please Select Category first" delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//    else{
    buttonStatus=2;
    [self.tableView setHidden:NO];
    [self.tableView reloadData];
    //}
}

- (IBAction)btWardNo:(id)sender {
//    if (strCategory.length==0||strCategoryType.length==0) {
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Please Select Category Type First" delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//    else{
    buttonStatus=3;
    [self.tableView setHidden:NO];
    [self.tableView reloadData];
   // }
}
- (IBAction)btnSubmit:(id)sender {
    if ([self.txtDescribeComplaint.text length]==0||[self.txtFullName.text length]==0||[self.txtAddress.text length]==0||[self.txtPincode.text length]==0||[self.txtMobileNO.text length]==0||[self.txtEmailId.text length]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter all fields" delegate:(id)self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([self.txtPincode.text length]!=6){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid pincode" delegate:(id)self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([self.txtMobileNO.text length]!=10){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid phone number" delegate:(id)self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSString *complaint=[self.txtDescribeComplaint text];
        NSString *name=[self.txtFullName text];
        NSString *address=[self.txtAddress text];
        NSString *pincode=[self.txtPincode text];
        NSString *mobile=[self.txtMobileNO text];
        NSString *email=[self.txtEmailId text];
        NSString *toker=[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
        NSString *deviceType=@"I";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        //using post
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:address,@"Address",strCategory,@"CategoryID",strCategoryType,@"CategoryTypeID",@"30/05/2015",@"DateGenerated",complaint,@"Description",deviceType,@"DeviceType",email,@"Email",mobile,@"Mobile",name,@"PersonName",strWardNo,@"Ward",pincode,@"Zipcode",toker,@"DeviceID",nil];
        //NSLog(@"-----%@",params);
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // if request JSON format
        [manager POST:@"http://www.aapnuchhotaudepur.com/CUSevaSadan_WS/Service.svc/json/ComplainRegister" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"RESPONSE: %@", responseObject);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            NSDictionary *dataDict1 = responseObject;
            //NSLog(@"dic1 : %@",dataDict1);
            [self fetchComplainDataResponse:dataDict1];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
           // NSLog(@"ERROR: %@", error);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];

    }
}
-(void)fetchComplainDataResponse:(NSDictionary *)dictionary{
   // NSLog(@"--------%@",[[dictionary objectForKey:@"ComplainRegisterResult"] valueForKey:@"ComplaintCode"]);
    if([[[dictionary objectForKey:@"ComplainRegisterResult"] valueForKey:@"ResponseCode"] integerValue]==1){
        
        NSString *str=[NSString stringWithFormat:@"Complain Number : %@",[[dictionary objectForKey:@"ComplainRegisterResult"] valueForKey:@"ComplaintCode"]];
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Successfully registered." message:str delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview setTag:2];
        [alertview show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 2)
    {
        if(buttonIndex == 0)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }
}

- (IBAction)btnUploadImage:(id)sender {
}

#pragma mark - Consume Web service methods

-(void) fetchComplainDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@%@",BASE_URL,FETCH_COMPLAINT_INFO_URL);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_COMPLAINT_INFO_URL]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self fetchDataResponse:dataDict];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Chhota Udepur" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
    
}
-(void)fetchDataResponse:(NSDictionary *)dictionary{
    
    dataDict=[dictionary valueForKey:@"FetchComplainInfoResult"];
    categoryArr=[dataDict objectForKey:@"lstComplaintCategory"];
    wardNoArr=[dataDict objectForKey:@"lstWard"];
   // NSLog(@"--->>%ld,---%ld",[categoryArr count],[wardNoArr count]);
//    [self.tableView reloadData];
    
}
#pragma mark- UITableView Datasource and Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger counter;
    if (buttonStatus==1) {
        counter=[categoryArr count];
    }
    else if (buttonStatus==2) {
       counter= [categoryTypeArr count];
    }
    else{
        counter=[wardNoArr count];
    }
   
    return counter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=(TenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (buttonStatus==1) {
        cell.lblComplainDetail.text=[[categoryArr objectAtIndex:indexPath.row] valueForKey:@"CategoryName"];
       // NSLog(@"-------%@",[[categoryArr objectAtIndex:indexPath.row] valueForKey:@"CategoryName"]);
    }
    else if(buttonStatus==2){
        cell=(TenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.lblComplainDetail.text=[[categoryTypeArr objectAtIndex:indexPath.row] valueForKey:@"CategoryTypeName"];
    }
    else{
        cell=(TenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
         cell.lblComplainDetail.text=[[wardNoArr objectAtIndex:indexPath.row] valueForKey:@"WardName"];
    }
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView setHidden:YES];
    if (buttonStatus==1) {
        
        [self.btnComplainCategory setTitle:[[categoryArr objectAtIndex:indexPath.row] valueForKey:@"CategoryName"] forState:UIControlStateNormal];
        strCategory=[[categoryArr objectAtIndex:indexPath.row] valueForKey:@"ComplaintCategoryID"];
        categoryTypeArr=[[categoryArr objectAtIndex:indexPath.row]valueForKey:@"lstComplaintCategoryType"];
        
    }
    else if (buttonStatus==2) {
        
        [self.btnComplainCategoryType setTitle:[[categoryTypeArr objectAtIndex:indexPath.row] valueForKey:@"CategoryTypeName"] forState:UIControlStateNormal];
        strCategoryType=[[categoryTypeArr objectAtIndex:indexPath.row] valueForKey:@"CategoryTypeID"];
    }
    else{
        [self.btWardNo setTitle:[[wardNoArr objectAtIndex:indexPath.row] valueForKey:@"WardName"] forState:UIControlStateNormal];
        strWardNo=[[wardNoArr objectAtIndex:indexPath.row] valueForKey:@"WardID"];
    }

}
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
