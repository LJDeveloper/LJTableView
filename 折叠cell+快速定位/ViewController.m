//
//  ViewController.m
//  折叠cell+快速定位
//
//  Created by 莱尔夫 on 2018/7/19.
//  Copyright © 2018年 莱尔夫. All rights reserved.
//

#import "ViewController.h"
#import "LJTempCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *LJTempTable;
    NSMutableArray *dataSource;
    NSMutableArray *sectionArr;
    NSMutableArray *stateArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"折叠cell测试";
    [self initDataSource];
    [self initTable];
    
   
}
- (void)initTable
{
    LJTempTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    LJTempTable.dataSource = self;
    LJTempTable.delegate = self;
//    LJTempTable.tableFooterView = [UIView new];
    [LJTempTable registerClass:[LJTempCell class] forCellReuseIdentifier:@"CELL"];
//    CGRect frame=CGRectMake(0, 0, 0, 0.01);
//    LJTempTable.tableHeaderView=[[UIView alloc]initWithFrame:frame];
    
    LJTempTable.sectionIndexColor = [UIColor blackColor];
    LJTempTable.sectionIndexTrackingBackgroundColor = [UIColor redColor];
    
    [self.view addSubview:LJTempTable];
    
}
- (void)initDataSource
{
    sectionArr  = [NSMutableArray arrayWithObjects:@"关于1",
                                  @"关于2",
                                  @"关于3",
                                  @"关于4",nil];

    
    NSArray *one = @[@"关于101",@"关于102",@"关于103"];
    NSArray *two = @[@"关于201",@"关于202",@"关于203"];
    NSArray *three = @[@"关于301",@"关于302",@"关于303"];
    NSArray *four = @[@"关于401",@"关于402",@"关于403"];
    
    dataSource = [NSMutableArray arrayWithObjects:one,two,three,four, nil];
    
    stateArr = [NSMutableArray array];
    
    for (int i = 0; i < dataSource.count; i++)
    {
        //所有的分区都是闭合
        [stateArr addObject:@"0"];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([stateArr[section] isEqualToString:@"1"]) {
        //如果是展开状态
        NSArray *array = [dataSource objectAtIndex:section];
        return array.count;
    }else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJTempCell *tempCell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    tempCell.lable.text = dataSource[indexPath.section][indexPath.row];
    tempCell.selectionStyle = UITableViewCellSelectionStyleDefault;
    tempCell.lable.textAlignment =  NSTextAlignmentCenter;
    return tempCell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (44-6)/2, 10, 6)];
    
    if ([stateArr[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([stateArr[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (44-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:sectionArr[section]];
    [button addSubview:tlabel];
    return button;
}
- (void)buttonPress:(UIButton *)sender
{
    //判断状态值
    if ([stateArr[sender.tag-1] isEqualToString:@"1"]) {
        [stateArr replaceObjectAtIndex:sender.tag-1 withObject:@"0"];
    }else
    {
        [stateArr replaceObjectAtIndex:sender.tag-1 withObject:@"1"];
    }
    [LJTempTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag -1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
//索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"%@,%ld",title,index);
    //点击索引，列表跳转到对应索引的行
   
    if ([stateArr[index] isEqualToString:@"0"]) {
        [stateArr replaceObjectAtIndex:index withObject:@"1"];
        [LJTempTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}
//返回索引数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
