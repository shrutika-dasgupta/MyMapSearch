//
//  COMSBaseViewController.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 2/12/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@import CoreLocation;


@interface COMSBaseViewController : UIViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet UIButton *UpdateButton;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *typePicker;
@property (strong, nonatomic)          NSArray *searchArray;
@property (strong, nonatomic)          NSString *typeSelected;
@property (strong, nonatomic) IBOutlet UIButton *dropButton;

@property(nonatomic) UIDynamicAnimator *animator;
@property(nonatomic) UIGravityBehavior *gravity;
@property(nonatomic) UICollisionBehavior *collision;


- (IBAction)checkEmptyString:(id)sender;

- (IBAction)sendInfo:(id)sender;
- (IBAction)InfoButtonClick:(UIButton *)sender;

@end
