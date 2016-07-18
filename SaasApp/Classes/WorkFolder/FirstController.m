//
//  FirstController.m
//  SaasApp
//
//  Created by ToothBond on 16/2/3.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

#import "FirstController.h"
#import "TableFieldController.h"

static NSString  * const kFirstCellTitle = @"tableViewWithTextField";
static NSString  * const kSencondCellTitle = @"icloud notes";

@interface FirstController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataList;
}

@property(nonatomic,strong)UITableView *mainTable;

@end

@implementation FirstController


-(id)init
{
    if (self = [super init]) {
        [self setupTabBarStyle];
        dataList = @[kFirstCellTitle,kSencondCellTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    [self.view addSubview:self.mainTable];
    
}

-(void)setupTabBarStyle
{
    self.title = @"UI";
//    self.tabBarItem.image = [UIImage imageNamed:@"tab_sch"];
//    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_sch_selected"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell identify";
    NSInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = dataList[row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = [dataList objectAtIndex:[indexPath row]];
    if ([title isEqualToString:kFirstCellTitle]) {
        TableFieldController *controller = [[TableFieldController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([title isEqualToString:kSencondCellTitle]) {
        
        TableFieldController *controller = [[TableFieldController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    
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
