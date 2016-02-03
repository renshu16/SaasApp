//
//  CustomPickView.h
//  SaasApp
//
//  Created by ToothBond on 15/11/20.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomPickView;
@protocol CustomPickDelegate <NSObject>
-(void)onSure:(CustomPickView*)target selectStr:(NSString*)selectStr index:(NSInteger)index;
-(void)onCancel:(CustomPickView*)target;
@end

enum PickType{
    CUSTOMTYPE = 1,
    DATETYPE,
    TIMETYPE,
    DATEANDTIMETYPE,
    COUNDOWNTIMETYPE
};

@interface CustomPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView * contain;
    UIPickerView * picker;
    UIDatePicker * datePicker;
    UIToolbar * tool;
    NSMutableArray * dataArr;
    NSInteger selectedIndex;
    NSString * selectedStr;
    int pickType;
}

@property(nonatomic,weak)id<CustomPickDelegate> delegate;
-(UIDatePicker*)getDatePicker;
-(UIPickerView*)getPickerView;
-(void)setPickType:(int)type;
-(void)setData:(NSArray*)data;
-(void)hidden:(BOOL)isAnimation;
-(void)show:(BOOL)isAnimation;

@end
