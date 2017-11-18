//
//  VSSegmentCntrl.m
//
//  Created by Vova Sarkisyan on 11/16/17.
//  Copyright © 2017 Vova Sarkisyan. All rights reserved.
//

#import "VSSegmentCntrl.h"

@implementation VSSegmentCntrl
{
    NSMutableArray * _labels;
    NSArray * _itemNames;
    UIView * _thumbView;
    
    UIColor * _selectedTxtColor;
    UIColor * _unSelectedTxtColor;
    UIColor * _unSelectedBckgColor;
    UIColor * _thumbColor;
    
    CGFloat _padding;
}

// INIT PROGRAMATICALLY
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        _selectedIndex = 0;
        [self setupView];
    }
    
    return self;
}


// WHEN LOADED FROM XIB
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        _labels = [[NSMutableArray alloc] init];
        _thumbView = [[UIView alloc] init];
        
        // default colors
        [self setDefaultColors];
        
        [self setupView];
    }

    return self;
}


- (void)setWithItems:(NSArray*)items selectedTxtColor:(UIColor*)selectedTxtColor unSelectedTxtColor:(UIColor*)unSelectedTxtColor selectedBckgColor:(UIColor*)selectedBckgColor unSelectedBckgColor:(UIColor*)unSelectedBckgColor
{
    _itemNames = items;
    
    _unSelectedTxtColor = unSelectedTxtColor;
    _selectedTxtColor = selectedTxtColor;
    _unSelectedBckgColor = unSelectedBckgColor;
    _thumbColor = selectedBckgColor;
    
    [self setupView];
}

- (void)setWithItems:(NSArray*)items
{
    _itemNames = items;
    [self setupView];
}


- (void)setFont:(UIFont *)font
{
    _font = font;
    [self setLabelsFont];
}



- (void)setDefaultColors
{
    self.backgroundColor = [UIColor clearColor];
    _thumbColor = [UIColor whiteColor];
    _unSelectedBckgColor =  [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1];
    _selectedTxtColor = [UIColor blackColor];
    _unSelectedTxtColor = [UIColor colorWithRed:177/255.f green:177/255.f blue:177/255.f alpha:1];
    
}

- (void)setupView
{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.backgroundColor = _unSelectedBckgColor;
    _thumbView.backgroundColor = _thumbColor;
    _padding = 2;
    
    [self setupLabels];
    
    [self insertSubview:_thumbView atIndex:0];
}

- (void)setupLabels
{
    [_labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_labels removeAllObjects];
    
    for(int i = 0; i < [_itemNames count]; i++)
    {
        UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 70, 40)];
        label.text = [_itemNames objectAtIndex:i];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Avenir-Black" size:15]; // default font
        
        label.textColor = (i == 0) ? _selectedTxtColor : _unSelectedTxtColor;
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addSubview:label];
        [_labels addObject:label];
        
    }
    
    [self addIndividualItemConstraintsForButtons:_labels mainView:self padding:_padding];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_itemNames)
    {
        CGRect frame = self.bounds;
        CGFloat newWidth = CGRectGetWidth(frame) / (CGFloat) [_itemNames count];
        frame.size.width = newWidth;
        _thumbView.frame = frame;
        _thumbView.backgroundColor = _thumbColor;
        _thumbView.layer.cornerRadius = _thumbView.frame.size.height / 2;
        
        [self displayNewSelectedIndex];
    }
}


- (void)displayNewSelectedIndex
{
    for(UILabel* label in _labels)
    {
        label.textColor  = _unSelectedTxtColor;
    }
    
    UILabel * label = _labels[_selectedIndex];
    label.textColor = _selectedTxtColor;

    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         _thumbView.frame = label.frame;
                     }
                     completion: nil];

}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView: self];
    
    int calculatedNdx = -1;
    for(int i = 0; i < [_labels count]; i++)
    {
        UILabel * label = [_labels objectAtIndex:i];
        if(CGRectContainsPoint(label.frame ,point))
        {
            calculatedNdx = i;
            break;
        }
    }
    
    if(calculatedNdx != -1){
        _selectedIndex = calculatedNdx;
        [self displayNewSelectedIndex];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    return NO;
}

- (void)addIndividualItemConstraintsForButtons:(NSArray*)items
                                      mainView:(UIView*)mainView
                                       padding:(CGFloat)padding
{
    int ndx = 0;
    
    for(UIView * item in items)
    {
        NSLayoutConstraint * rightConstraint;
        NSLayoutConstraint * leftConstraint;
        
        NSLayoutConstraint * topConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeTop multiplier:1 constant:padding];

        NSLayoutConstraint * bottomConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeBottom multiplier:1 constant:-padding];
        
        
        // RIGHT CONSTRAINT
        if(item == [items lastObject])
        {
            rightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeRight multiplier:1 constant:-padding];
        }
        else{
            UIButton * nextItem = [items objectAtIndex:ndx + 1];
            rightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nextItem attribute:NSLayoutAttributeLeft multiplier:1 constant: -padding];
        }
        
        // LEFT CONSTRAINT
        if(ndx == 0)
        {
            leftConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1 constant: padding];
        }
        else
        {
            UIButton * prevItem = [items objectAtIndex:ndx - 1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prevItem attribute:NSLayoutAttributeRight multiplier:1 constant: padding];
            
            UIButton * firstBttn = [items objectAtIndex:0];
            NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:firstBttn attribute:NSLayoutAttributeWidth multiplier:1 constant: padding];
            
            [mainView addConstraint:widthConstraint];
            
        }
        
        [mainView addConstraints:@[topConstraint, bottomConstraint, rightConstraint, leftConstraint]];
        
        ndx++;
    }
}


- (void)setLabelsFont
{
    NSLog(@"<CSegmentCntrl> setLabelsFont:");
    for(UILabel * label in _labels)
    {
        label.font = _font;
    }
}

@end
