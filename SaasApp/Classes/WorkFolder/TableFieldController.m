//
//  TableFieldController.m
//  SaasApp
//
//  Created by ToothBond on 16/2/3.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

#import "TableFieldController.h"

static CGFloat const CELL_EDITTEXT_TAG = 4900;

@interface TableFieldController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataList;
}

@property (nonatomic,strong) UITableView    *mainTable;

@end

@implementation TableFieldController

-(instancetype)init
{
    self = [super init];
    if (self) {
        dataList = [[NSMutableArray alloc] init];
        for (int i=0; i<10; i++) {
            [dataList addObject:[NSString stringWithFormat:@"field%d",i]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTable];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const identify = @"field cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    [self setupEditTableViewCell:cell withIndex:[indexPath row]];
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


-(void)textFieldDidChange:(UITextField *)textField
{
    
}


-(void)setupEditTableViewCell:(UITableViewCell *)cell withIndex:(NSInteger)row
{
    static CGFloat leftPadding = 14;
    static CGFloat rightPadding = 28;
    CGFloat cellHeight = cell.bounds.size.height;
    CGFloat cellWidth = cell.bounds.size.width;
    
    UITextField *editText = (UITextField *)[cell.contentView viewWithTag:CELL_EDITTEXT_TAG + row];
    if (editText == nil) {
        editText = [[UITextField alloc] init];
        editText.font = font_main_content;
        editText.textColor = color_font_subtext_black;
        //editText.delegate = self;
        editText.tag = CELL_EDITTEXT_TAG + row;
        [editText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [editText setPlaceholder:[dataList objectAtIndex:row]];
        [cell.contentView addSubview:editText];
    }
    CGFloat editTextWidth = cellWidth - leftPadding - rightPadding;
    editText.frame = CGRectMake(leftPadding , 0, editTextWidth, cellHeight);
    
}

- (UITableView *)mainTable
{
    if (_mainTable == nil){
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
    }
    return _mainTable;
}

@end
