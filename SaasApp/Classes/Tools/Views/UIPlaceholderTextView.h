//
//  UIPlaceholderTextView.h
//  Order
//
//  Created by ToothBond on 15/1/10.
//
//

#import <UIKit/UIKit.h>

@interface UIPlaceholderTextView : UITextView<UITextViewDelegate>
{
    UITextView * placeHolderView;
    NSString * placeHolder;
}
@property NSInteger maxCount;
-(void)setPlaceholder:(NSString*)str;
-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知
@end
