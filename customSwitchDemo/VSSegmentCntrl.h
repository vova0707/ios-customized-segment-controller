//
//  VSSegmentCntrl.h
//
//  Created by Vova Sarkisyan on 11/16/17.
//  Copyright © 2017 Vova Sarkisyan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VSSegmentCntrl : UIControl

@property (nonatomic) int selectedIndex;
@property (nonatomic, strong) UIFont * font;


// SETUP & CUSTOMIZE THE SEGMENT CONTROLLER
- (void)setWithItems:(NSArray*)items;

- (void)setWithItems:(NSArray*)items selectedTxtColor:(UIColor*)selectedTxtColor unSelectedTxtColor:(UIColor*)unSelectedTxtColor selectedBckgColor:(UIColor*)selectedBckgColor unSelectedBckgColor:(UIColor*)unSelectedBckgColor;


@end
