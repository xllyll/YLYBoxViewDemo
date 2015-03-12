//
//  ViewController.m
//  YLYBoxViewDemo
//
//  Created by xinyu_mac on 15/3/12.
//  Copyright (c) 2015年 xllyll. All rights reserved.
//

#import "ViewController.h"
#import "YLYBoxView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet YLYBoxView *boxView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setboxViewTimeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setboxViewTimeData{
    NSString *json = @"{\"date\":[{\"times\":[\"9:30\",\"16:00\",],\"week\":1},{\"times\":[\"8:00\",\"8:30\",\"9:00\",\"9:30\",\"16:00\",\"21:00\"],\"week\":2},{\"times\":[],\"week\":3},{\"times\":[\"19:30\",\"16:00\",],\"week\":4},{\"times\":[],\"week\":5},{\"times\":[],\"week\":6},{\"times\":[\"11:30\",\"16:00\",\"19:30\",\"20:00\"],\"week\":7}]}";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *list = rootDic[@"date"];
    _boxView.timeData.array = list;
    [_boxView relaodData:0];
}
@end
