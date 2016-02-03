//
//  TBButton.m
//  Order
//
//  Created by ToothBond on 15/5/9.
//
//

#import "TBButton.h"
#import "UIImage+TBColor.h"

@implementation TBButton
-(id)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

-(void)config
{
    self.backgroundColor = RGBACOLOR(1, 1, 1, 0);
    self.userInteractionEnabled = YES;
    higDur = 0.1;
//    higColor = RGBACOLOR(1, 1, 1, 0.3f);
    higColor = color_btn_highlight_gray;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self setImage:[UIImage imageWithColor:higColor size:CGSizeMake(1, 1)]];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self cancelHig];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self performSelector:@selector(cancelHig) withObject:nil afterDelay:higDur];
    if(target != nil && [target respondsToSelector:action]){
        //[target performSelector:action withObject:self];
        //fix ARC warning : "performSelector may cause a leak because its selector is unknown"
        IMP imp = [target methodForSelector:action];
        void (*func)(id, SEL, TBButton*) = (void *)imp;
        func(target, action, self);
    }

}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self performSelector:@selector(cancelHig) withObject:nil afterDelay:higDur];
}
-(void)cancelHig
{
    [self setImage:nil];
}
-(void)addTarget:(id)_target action:(SEL)_action
{
    target = _target;
    action = _action;
}
-(void)setHigColor:(UIColor *)_color
{
    higColor = _color;
}
-(void)setHigDur:(CGFloat)_dur
{
    higDur = _dur;
}
@end
