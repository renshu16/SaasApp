//
//  TBButton.h
//  Order
//
//  Created by ToothBond on 15/5/9.
//
//

#import <UIKit/UIKit.h>

@interface TBButton : UIImageView
{
    __weak id target;
    SEL action;
    UIColor * higColor;
    CGFloat higDur;
}
-(void)addTarget:(id)_target action:(SEL)_action;
-(void)setHigColor:(UIColor*)_color;
-(void)setHigDur:(CGFloat)_dur;
@end
