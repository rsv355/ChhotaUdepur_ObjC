//
//  TouristsViewController.h
//  ChotaUdepur
//
//  Created by webmyne systems on 17/05/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"

@interface TouristsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)btnBack:(id)sender;
@end
