//
//  ViewController.h
//  customSwitchDemo
//
//  Created by Vova Sarkisyan on 11/18/17.
//  Copyright © 2017 com.vova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSSegmentCntrl.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *topContainerView;
@property (strong, nonatomic) IBOutlet VSSegmentCntrl *topSementCntrl;
@property (strong, nonatomic) IBOutlet UILabel *topLbl;
- (IBAction)topSgmntValueChanged:(VSSegmentCntrl *)sender;


@property (strong, nonatomic) IBOutlet VSSegmentCntrl *bottomSgmntCntrll;

@property (strong, nonatomic) IBOutlet UILabel *bottomLbl;
- (IBAction)buttomSgmntValueChanged:(VSSegmentCntrl *)sender;

@end

