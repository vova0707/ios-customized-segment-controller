//
//  ViewController.m
//  customSwitchDemo
//
//  Created by Vova Sarkisyan on 11/18/17.
//  Copyright © 2017 com.vova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray * _topOptions;
    NSArray * _bottomOptions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    _topContainerView.layer.borderColor = [UIColor grayColor].CGColor;
    _topContainerView.layer.borderWidth = 2;
    
    // USING DEFAULT VALUES
    _topOptions = @[@"USA", @"Europe", @"Mexico"];
    [_topSementCntrl setWithItems:_topOptions];
    
    // MORE CUSTOMIZED EXAMPLE
    _bottomOptions = @[@"APPLE", @"ORANGE", @"BANANA"];
    [_bottomSgmntCntrll setWithItems:_bottomOptions selectedTxtColor:[UIColor whiteColor] unSelectedTxtColor:[UIColor blackColor] selectedBckgColor:[UIColor blackColor] unSelectedBckgColor:[UIColor whiteColor]];
    _bottomSgmntCntrll.font = [UIFont fontWithName:@"Avenir-Black" size:10];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// FOR THE ONE THAT LODAED FROM XIB
- (IBAction)topSgmntValueChanged:(VSSegmentCntrl *)sender {
    
    [_topLbl setText:_topOptions[sender.selectedIndex]];

}

- (IBAction)buttomSgmntValueChanged:(VSSegmentCntrl *)sender {
    [_bottomLbl setText:_bottomOptions[sender.selectedIndex]];
}
@end
