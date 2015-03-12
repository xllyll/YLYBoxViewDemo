//
//  YLYBoxView.m
//  Demo002
//
//  Created by yangluyin_mac on 15/3/11.
//  Copyright (c) 2015年 xllyll. All rights reserved.
//

#import "YLYBoxView.h"

#define KLEFT_TEBLE_VIEW_TAT 10001
#define KRIGHT_TEBLE_VIEW_TAT 10002

#define K_leftTableView_hight 50
#define K_rightTableView_hight 50
#define K_rightTableView_title_hight 40

@interface YLYBoxView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _width;
    NSInteger _hight;
    
    NSInteger _left_table_width;
    NSInteger _right_table_width;
    
    NSArray *_left_table_data;
    NSArray *_right_table_data;
    NSArray *_right_table_title_data;
    
    UITableViewCell *_currtentCell;//当前选中cell
    
    NSMutableArray *buttons;
    
    NSInteger _left_table_select_index;
}

/**
 *左边的tableView
 */
@property (strong , nonatomic)UITableView *leftTableView;
/**
 *右边的tableView
 */
@property (strong , nonatomic)UITableView *rightTableView;
@end

@implementation YLYBoxView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)awakeFromNib{
    [self initConfig];
    
}

-(void)initConfig{
    _timeData = [NSMutableArray arrayWithArray:@[@{@"times":@[],@"week":@"1"},
                                                 @{@"times":@[],@"week":@"2"},
                                                 @{@"times":@[],@"week":@"3"},
                                                 @{@"times":@[],@"week":@"4"},
                                                 @{@"times":@[],@"week":@"5"},
                                                 @{@"times":@[],@"week":@"6"},
                                                 @{@"times":@[],@"week":@"7"}]];
    buttons = [NSMutableArray array];
    _width = self.bounds.size.width;
    _hight = self.bounds.size.height;
    
    _left_table_width = _width/7*2;
    _right_table_width = _width-_left_table_width;
    
    _left_table_data  = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    _right_table_title_data = @[@"早上",@"中午",@"晚上"];
    _right_table_data = @[@[@"8:00",@"8:30",@"9:00",@"9:30",@"10:00",@"10:30",@"11:00",@"11:30"],
                          @[@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30"],
                          @[@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00"]];
    
    [self buildCenterView];
}
-(void)buildCenterView{
    [self buildLeftTableView];
    
    [self buildRightTableView];
}
-(void)buildLeftTableView{
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _left_table_width, _hight) style:UITableViewStylePlain];
    _leftTableView.dataSource = self;
    _leftTableView.delegate   = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.tag = KLEFT_TEBLE_VIEW_TAT;
    [self addSubview:_leftTableView];
    [_leftTableView reloadData];
    [self layoutTableView:_leftTableView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_left_table_width-2, 0, 2, _hight)];
    lineView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self addSubview:lineView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:_leftTableView didSelectRowAtIndexPath:indexPath];
}
-(void)buildRightTableView{
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(_left_table_width, 0, _right_table_width, _hight) style:UITableViewStylePlain];
    _rightTableView.dataSource = self;
    _rightTableView.delegate   = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.tag = KRIGHT_TEBLE_VIEW_TAT;
    [self addSubview:_rightTableView];
    [_rightTableView reloadData];
    [self layoutTableView:_rightTableView];
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == KLEFT_TEBLE_VIEW_TAT) {
        return 1;
    }
    if (tableView.tag == KRIGHT_TEBLE_VIEW_TAT) {
        return 3;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == KLEFT_TEBLE_VIEW_TAT) {
        return _left_table_data.count;
    }
    if (tableView.tag == KRIGHT_TEBLE_VIEW_TAT) {
        return 2;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"Cell1";
    static NSString *cellID2 = @"Cell2";
    static NSString *cellID3 = @"Cell3";
    UITableViewCell *cell;
    if (tableView.tag == KLEFT_TEBLE_VIEW_TAT) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _leftTableView.bounds.size.width, K_leftTableView_hight-2)];
            view.backgroundColor = [UIColor whiteColor];
            [cell addSubview:view];
            UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
            label.tag = 11;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = _left_table_data[indexPath.row];
            [view addSubview:label];
        }
        UIColor *color = [UIColor colorWithRed:54.0/255.0 green:179.0/255.0 blue:190.0/255.0 alpha:1.0f];
        //通过RGB来定义自己的颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = color;
    }
    if (tableView.tag == KRIGHT_TEBLE_VIEW_TAT) {
        if (indexPath.row==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, K_rightTableView_title_hight)];
                label.text = _right_table_title_data[indexPath.section];
                [label sizeToFit];
                CGRect rect = label.frame;
                rect.size.height = K_rightTableView_title_hight;
                label.frame = rect;
                [cell addSubview:label];
                
                //全选按钮
                UIButton *cBt = [UIButton buttonWithType:UIButtonTypeCustom];
                [cBt setImage:[UIImage imageNamed:@"check_false"] forState:UIControlStateNormal];
                [cBt setImage:[UIImage imageNamed:@"check_true"] forState:UIControlStateSelected];
                cBt.frame = CGRectMake(label.frame.size.width+20, 10, K_rightTableView_title_hight-10*2, K_rightTableView_title_hight-10*2);
                [cBt addTarget:self action:@selector(chooseAllTime:) forControlEvents:UIControlEventTouchUpInside];
                cBt.tag = indexPath.section+1;
                [cell addSubview:cBt];
            }
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
            }
            NSInteger btWidth = (_right_table_width-3*4)/3;
            NSInteger btHight = K_rightTableView_hight-6;
            NSArray *array = _right_table_data[indexPath.section];
            
            NSInteger l = [array count]/3;
            if ([_right_table_data[indexPath.section] count]%3!=0) {
                l++;
            }
            
            for (int i = 0; i<l; i++) {
                if (i==l-1) {
                    NSInteger number = [_right_table_data[indexPath.section] count]%3;
                    if (number==0) {
                        number = 3;
                    }
                    for (int k = 0; k<number; k++) {
                        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(btWidth*k+3*(k+1), K_rightTableView_hight*i+3, btWidth, btHight)];
                        NSString *string =array[i*3+k];
                        [bt setTitle:string forState:UIControlStateNormal];
                        bt.backgroundColor = [UIColor whiteColor];
                        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [bt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                        [bt setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:54.0/255.0 green:179.0/255.0 blue:190.0/255.0 alpha:1.0f]]  forState:UIControlStateSelected];
                        [bt setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]  forState:UIControlStateNormal];
                        bt.tag = i*3+k+1;
                        [cell addSubview:bt];
                        [buttons addObject:bt];
                    }
                }else{
                    for (int k = 0; k<3; k++) {
                        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(btWidth*k+3*(k+1), K_rightTableView_hight*i+5, btWidth, btHight)];
                        [bt setTitle:array[i*3+k] forState:UIControlStateNormal];
                        bt.backgroundColor = [UIColor whiteColor];
                        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [bt setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:54.0/255.0 green:179.0/255.0 blue:190.0/255.0 alpha:1.0f]]  forState:UIControlStateSelected];
                        [bt setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]  forState:UIControlStateNormal];
                        [bt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                        bt.tag = i*3+k+1;
                        [cell addSubview:bt];
                        [buttons addObject:bt];
                    }
                }
            }
        }
        //无色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == KLEFT_TEBLE_VIEW_TAT) {
        return K_leftTableView_hight;
    }
    if (tableView.tag == KRIGHT_TEBLE_VIEW_TAT){
        if (indexPath.row==0) {
            return K_rightTableView_title_hight;
        }else{
            NSInteger count = [_right_table_data[indexPath.section] count];
            NSInteger number = count/3;
            if (count%3!=0) {
                number++;
            }
            return K_rightTableView_hight*number;
        }
    }
    return 44;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableView.tag==KRIGHT_TEBLE_VIEW_TAT) {
//        return _right_table_title_data[section];
//    }
//    return nil;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == KLEFT_TEBLE_VIEW_TAT) {
        [_currtentCell setSelected:NO];
        UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:YES];
        _currtentCell = cell;
        [self closeRightTableViewButton];
        [self reloadRightTableView:indexPath.row];
        _left_table_select_index = indexPath.row;
    }
    if (tableView.tag == KRIGHT_TEBLE_VIEW_TAT){
        
    }
}
-(void)layoutTableView:(UITableView*)tableView{
    CGRect rect = tableView.frame;
    NSInteger h = tableView.contentSize.height;
    if (h<rect.size.height) {
        rect.size.height = h;
        tableView.frame =rect;
        tableView.scrollEnabled = NO;
    }
}

-(void)setTimeData:(NSMutableArray *)timeData{
    _timeData = timeData;
    [self reloadRightTableView:0];
}
-(void)closeRightTableViewButton{
    for (UIButton *bt in buttons) {
        bt.selected = NO;
    }
}
-(void)reloadRightTableView:(NSInteger)index{
    
    if (_timeData.count==7) {
        NSArray *times = _timeData[index][@"times"];
        for (int i = 0; i <3; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:i];
            UITableViewCell *cell = [_rightTableView cellForRowAtIndexPath:indexPath];
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:i];
            UITableViewCell *cell1 = [_rightTableView cellForRowAtIndexPath:indexPath1];
            UIButton *sender = (UIButton*)[cell1 viewWithTag:i+1];
            int key = 0;
            for (int j = 0 ;j<times.count;j++) {
                NSString *t = times[j];
                for (int k = 0 ;k<[_right_table_data[i] count];k++) {
                    NSString *ts=_right_table_data[i][k];
                    if ([t isEqualToString:ts]) {
                        UIButton *bt = (UIButton*)[cell viewWithTag:k+1];
                        bt.selected = YES;
                        key++;
                    }
                }
            }
            sender.selected = NO;
            if (key == [_right_table_data[i] count]) {
                sender.selected = YES;
            }
        }
    }
}
//TODO:bt click
-(void)buttonClick:(UIButton*)sender{
    BOOL select = sender.selected;
    NSString *string = sender.titleLabel.text;
    if (select==YES) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    NSMutableDictionary *dictonary = [NSMutableDictionary dictionaryWithDictionary:_timeData[_left_table_select_index]];
    NSMutableArray *array = [NSMutableArray arrayWithArray:dictonary[@"times"]];
    if ([array containsObject:string]) {
        NSLog(@"包含");
        if (sender.selected == NO) {
            [array removeObject:string];
        }
        
    }else{
        [array addObject:string];
        NSLog(@"不包含");
    }
    [dictonary setObject:array forKey:@"times"];
    NSMutableArray *list = [NSMutableArray arrayWithArray:_timeData];
    [list removeObjectAtIndex:_left_table_select_index];
    [list insertObject:dictonary atIndex:_left_table_select_index];
    
    _timeData = list;
    
}
//TODO:全选事件
-(void)chooseAllTime:(UIButton*)sender{
    BOOL select = sender.selected;
    if (select==YES) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    [self chooseAllTime:sender.tag-1 isOn:sender.selected];
}
-(void)chooseAllTime:(NSInteger)index isOn:(BOOL)isOn {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:index];
    UITableViewCell *cell = [_rightTableView cellForRowAtIndexPath:indexPath];
    for (int i = 0 ; i< [_right_table_data[index] count];i++) {
        UIButton *bt = (UIButton*)[cell viewWithTag:i+1];
        bt.selected = isOn;
    }
    NSMutableDictionary *dictonary = [NSMutableDictionary dictionaryWithDictionary:_timeData[_left_table_select_index]];
    NSMutableArray *array = [NSMutableArray arrayWithArray:dictonary[@"times"]];
    
    NSMutableArray *dates = [NSMutableArray arrayWithArray:_right_table_data[index]];
    for (NSString *date in dates) {
        if (![array containsObject:date]) {
            if (isOn == YES) {
                [array addObject:date];
            }else{
                //[array removeObject:date];
            }
        }else{
            if (isOn == YES) {
                //[array addObject:date];
            }else{
                [array removeObject:date];
            }
        }
    }
    [dictonary setObject:array forKey:@"times"];
    NSMutableArray *list = [NSMutableArray arrayWithArray:_timeData];
    [list removeObjectAtIndex:_left_table_select_index];
    [list insertObject:dictonary atIndex:_left_table_select_index];
    _timeData = list;
    
}
//TODO:UIColor 转UIImage
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(void)relaodData:(NSInteger)index{
    [self reloadRightTableView:index];
}
@end
