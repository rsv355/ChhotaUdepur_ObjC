//
//  AboutUsViewController.h
//  ChotaUdepur
//
//  Created by webmyne systems on 16/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface AboutUsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblAboutUs;
@property (weak, nonatomic) IBOutlet AsyncImageView *imageAboutUs;

- (IBAction)btnBack:(id)sender;
@end
