//
//  CustomPickView.m
//  SaasApp
//
//  Created by ToothBond on 15/11/20.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "CustomPickView.h"


@implementation CustomPickView
@synthesize delegate;
-(id)init
{
    self = [super init];
    [self initControls];
    return self;
}
-(void)dealloc
{
    DEBUG_NSLOG(@"%s",__FUNCTION__);
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initControls];
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(0, 0, screenWidth, screenHeight - 20 - 44)];
    [picker setFrame:CGRectMake(0, 44, self.frame.size.width, 180)];
    [tool setFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
}
-(void)initControls
{
    delegate = nil;
    pickType = CUSTOMTYPE;
    [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight - 20 - 44)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    contain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, (pickType == CUSTOMTYPE ? 224 : 260))];
    [self addSubview:contain];
    [self initToolBar];
    dataArr = [[NSMutableArray alloc] init];
    picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [picker setShowsSelectionIndicator:YES];
    [picker setBackgroundColor:[UIColor whiteColor]];
    [picker setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];//自定义高度，默认是216
    [picker setFrame:CGRectMake(0, 44, self.frame.size.width, 180)];
    [contain addSubview:picker];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, screenWidth, 216)];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setBackgroundColor:[UIColor whiteColor]];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    [datePicker setLocale:locale];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [contain addSubview:datePicker];
    [self setUserInteractionEnabled:YES];
    [self hidden:NO];
}
-(void)hidden:(BOOL)isAnimation
{
    if(!self.userInteractionEnabled)
        return;
    [self setUserInteractionEnabled:NO];
    if(isAnimation)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [contain setCenter:CGPointMake(screenWidth/2, self.frame.size.height+contain.frame.size.height/2)];
        [UIView commitAnimations];
    }
    else
        [contain setCenter:CGPointMake(screenWidth/2, self.frame.size.height+contain.frame.size.height/2)];
}
-(void)show:(BOOL)isAnimation
{
    if(self.userInteractionEnabled)
        return;
    
    [self setUserInteractionEnabled:YES];
    [picker setHidden:(pickType == CUSTOMTYPE ? NO : YES)];
    [datePicker setHidden:((pickType != CUSTOMTYPE) ? NO : YES)];
    [contain setFrame:CGRectMake(contain.frame.origin.x, contain.frame.origin.y, screenWidth, (pickType == CUSTOMTYPE ? 224 : 260))];
    
    if(pickType == CUSTOMTYPE)
    {
        selectedIndex = [picker selectedRowInComponent:0];
//        if(selectedIndex == 0)
//        {
//            [picker selectRow:dataArr.count/2 inComponent:0 animated:NO];
//            selectedIndex = dataArr.count/2;
//        }
        selectedStr = (NSString*)[dataArr objectAtIndex:selectedIndex];
    }
    else
    {
        if(pickType == DATETYPE)
            [datePicker setDatePickerMode:UIDatePickerModeDate];
        else if(pickType == TIMETYPE)
            [datePicker setDatePickerMode:UIDatePickerModeTime];
        else if(pickType == DATEANDTIMETYPE)
            [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        else if(pickType == COUNDOWNTIMETYPE)
            [datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        [self dateChanged:datePicker];
    }
    if(isAnimation)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [contain setCenter:CGPointMake(screenWidth/2, self.frame.size.height-contain.frame.size.height/2)];
        [UIView commitAnimations];
    }
    else
        [contain setCenter:CGPointMake(screenWidth/2, self.frame.size.height-contain.frame.size.height/2)];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelAction:nil];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(dataArr.count == 0)
        return 0;
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dataArr.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataArr objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedIndex = row;
    selectedStr = (NSString*)[dataArr objectAtIndex:row];
}
-(void)dateChanged:(UIDatePicker*)sender
{
    selectedIndex = -1;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    if(pickType == DATETYPE)
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if(pickType == TIMETYPE)
        [dateFormatter setDateFormat:@"HH:mm"];
    selectedStr = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:sender.date]] copy];
}
-(void)setData:(NSArray *)data
{
    [dataArr removeAllObjects];
    [dataArr addObjectsFromArray:data];
    [picker reloadAllComponents];
}
-(void)setPickType:(int)type
{
    pickType = type;
    if(pickType == DATETYPE)
        [datePicker setDatePickerMode:UIDatePickerModeDate];
    else if(pickType == TIMETYPE)
        [datePicker setDatePickerMode:UIDatePickerModeTime];
    else if(pickType == DATEANDTIMETYPE)
        [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    else if(pickType == COUNDOWNTIMETYPE)
        [datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
}
-(UIDatePicker*)getDatePicker
{
    return datePicker;
}
-(UIPickerView*)getPickerView
{
    return picker;
}
-(void)initToolBar
{
    tool = [[UIToolbar alloc] init];
    [tool setFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [tool setTintColor:[UIColor grayColor]];
    NSMutableArray *myToolBarItems = [NSMutableArray array];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    //完成
    UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(sureAction:)];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(cancelAction:)];
    
    [myToolBarItems addObject:cancelItem];
    [myToolBarItems addObject:spaceItem];
    [myToolBarItems addObject:sureItem];
    
    [tool setItems:myToolBarItems];
    [contain addSubview:tool];
}
-(void)sureAction:(UIButton*)btn
{
    [self hidden:YES];
    if(delegate != nil && [delegate respondsToSelector:@selector(onSure:selectStr:index:)])
        [delegate onSure:self selectStr:selectedStr index:selectedIndex];
}
-(void)cancelAction:(UIButton *)btn
{
    [self hidden:YES];
    if(delegate != nil && [delegate respondsToSelector:@selector(onCancel:)])
        [delegate onCancel:self];
}

@end
