//
//  UIPlaceholderTextView.m
//  Order
//
//  Created by ToothBond on 15/1/10.
//
//

#import "UIPlaceholderTextView.h"

@implementation UIPlaceholderTextView
@synthesize maxCount;
- (id) initWith{
    if ((self = [super init])) {
        [self addObserver];
        placeHolderView = [[UITextView alloc] initWithFrame:self.bounds];
        [placeHolderView setUserInteractionEnabled:NO];
        [placeHolderView setTextColor:color_font_placeholder];
        [self addSubview:placeHolderView];
    }
    return self;
}
- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addObserver];
        placeHolderView = [[UITextView alloc] initWithFrame:self.bounds];
        [placeHolderView setUserInteractionEnabled:NO];
        [placeHolderView setTextColor:color_font_placeholder];
        [self addSubview:placeHolderView];
    }
    return self;
}
-(void)dealloc
{
    if(placeHolderView != nil){
        placeHolderView = nil;
    }
    [self removeobserver];
}
-(void)addObserver
{
    maxCount = INT32_MAX;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginTextChange:) name:UITextViewTextDidChangeNotification object:self];
}
-(void)removeobserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [placeHolderView setFont:font];
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [placeHolderView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}
-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
//    [placeHolderView setBackgroundColor:backgroundColor];
    [placeHolderView setBackgroundColor:[UIColor clearColor]];
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self beginTextChange:nil];
}
-(void)setPlaceholder:(NSString *)str
{
    placeHolder = [str copy];
    [placeHolderView setText:placeHolder];
    [self beginTextChange:nil];
}

- (void)beginTextChange:(NSNotification*) notification
{
    @try {
        
    if(self.text != nil && self.text.length > 0)
        [placeHolderView setHidden:YES];
    else
        [placeHolderView setHidden:NO];
        
        if(self.text.length > maxCount){
            NSString * tmp = [self.text substringToIndex:maxCount - 1];
            [self setMarkedText:@"" selectedRange:NSMakeRange(0, 0)];
            [super setText:tmp];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}
//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onTBTextViewClick:)]){
//        if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
//            return NO;
//    }
//    return YES;
//}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesEnded:touches withEvent:event];
//    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onTBTextViewClick:)])
//        [self.delegate performSelector:@selector(onTBTextViewClick:) withObject:nil];
//}
@end