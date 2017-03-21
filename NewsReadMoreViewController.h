//
//  NewsReadMoreViewController.h
//  ChotaUdepur
//
//  Created by webmyne systems on 27/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMLLabel.h"

@interface NewsReadMoreViewController : UIViewController


@property (strong,nonatomic) NSString *imageURL;
@property (strong,nonatomic) NSString *strDate;
@property (strong,nonatomic) NSString *strNewsTitle;
@property (strong,nonatomic) NSString *strDescription;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet HTMLLabel *lblNewsTitle;
@property (weak, nonatomic) IBOutlet HTMLLabel *lblNewsDescription;

@end
