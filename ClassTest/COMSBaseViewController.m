//
//  COMSBaseViewController.m
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 2/12/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "COMSBaseViewController.h"
#import <COMSMapManager/COMSMapManager.h>
#import "COMSMapViewController.h"

@interface COMSBaseViewController ()



@end

@implementation COMSBaseViewController
@synthesize dropButton;

#pragma mark - Loading methods



/*
 Automatically called by the view controller
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //Enable the UpdateButton
    [self.UpdateButton setEnabled:NO];
    
    //The code for setting the background
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image.jpg"]]];
    
    self.searchArray = [[NSArray alloc] initWithObjects:
                              @"All",
                              @"Amusement Park",
                              @"Bar",
                              @"Bus Station",
                              @"Cafe",
                              @"Establishment",
                              @"Food",
                              @"Gym",
                              @"Health",
                              @"Home Good Store",
                              @"Library",
                              @"Movie Theatre",
                              @"Museum",
                              @"Park",
                              @"Restaurant",
                              @"University",
                              @"Zoo"
                              , nil];
    
    self.typeSelected = self.searchArray[0];
 
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(buttonMoveAround:)];
    
    [self.dropButton addGestureRecognizer:pan];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc]initWithItems:@[self.dropButton]];
    [self.gravity setAngle:M_PI/2 magnitude:3];
    [self.animator addBehavior:self.gravity];
    
    self.collision = [[UICollisionBehavior alloc]initWithItems:@[self.dropButton]];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:self.collision];
    
    double delayInSeconds = 2.0;
    
    dispatch_time_t pop = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(pop, dispatch_get_main_queue(), ^(void){
      
        [self.gravity addItem:self.dropButton];
    });
    
    
    //make ourselves the delegate of the textfield so we can be notified of changes by it
    self.inputTextField.delegate = self;
}


- (IBAction)buttonMoveAround:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.view.window];
    
    sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
}

- (IBAction)InfoButtonClick:(UIButton *)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"HELP" message:@"1. Type in the place you want to search and click 'Search'\n2. Then select the distance in the slider\n3. You can click on the details tab to get more list info about the places searched.\n4. Click on the cell and get the detailed view of the place.\n5. You can select your favorite place and store in the database.\n6. You can delete the entry in the favorites tab by Swiping or by deleting all the entries by clicking on 'Delete All' button" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)updateLabelPressed:(UIButton *)sender {
    
    //set the display label text to that of the textfield
    
    //resign first responder (hide the keyboard)
        [self.inputTextField resignFirstResponder];
   
}

#pragma mark - Gesture recognizers
/*
 Actions when a certain view is tapped. In this case we added this recognizer to the main view (self.view) so that the keyboard will dismiss when the screen is tapped
 */
- (IBAction)screenTapped:(UITapGestureRecognizer *)sender {
    
    //The textfield has a property called first responder. The keyboard is this textfields accessory view. When the textfield is in first responder mode, it means it is the primary focus on the screen (the textfield cursor is blinking, keyboard is up). To dismiss the keyboard, we tell it to resignFirstResponder status
    if (self.inputTextField.isFirstResponder) {
        [self.inputTextField resignFirstResponder];
    }
}


- (IBAction)checkEmptyString:(id)sender {
    /*
        Checks for empty string in the textField box
     if the String is empty then the update button will remain dissabled
     the search button will be enabled only if the some text is entered in the text field
     */
    if([self.inputTextField.text length] != 0)
    {
        [self.UpdateButton setEnabled:YES];
    }
    else
    {
        [self.UpdateButton setEnabled:NO];
    }
}
//the function called whenever the information is sent through the segue
- (IBAction)sendInfo:(id)sender {
}

//Preparing the segue for passing the the textfield that is typed when the button is pushed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"sendInfo"]) {
        COMSMapViewController *detailViewController = [segue destinationViewController];
        
        //This is the id infoRequest, which is a pointer to the object
        //Look at the viewDidLoad in the Destination implementation.
        detailViewController.textPassed = self.inputTextField.text;
        detailViewController.typePassed = self.typeSelected;
      }
}



// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.searchArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.searchArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.typeSelected = self.searchArray[row];
  //  NSLog(@"TYPE SELECTED:*****---->%@......%d",self.searchArray[row], row);
}
@end
