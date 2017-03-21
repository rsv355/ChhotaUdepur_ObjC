//
//  TenderTableViewCell.h
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TenderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblSerialNo;
@property (weak, nonatomic) IBOutlet UILabel *lblTenderNo;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblParticular;
@property (weak, nonatomic) IBOutlet UILabel *lblTenderDetails;

//--Complain Details
@property (weak, nonatomic) IBOutlet UILabel *lblComplainDetail;
@end
