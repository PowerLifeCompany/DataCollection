//
//  PileInfoMainView.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoMainView.h"

@implementation PileInfoMainView

- (void)awakeFromNib
{
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    if(dataArray){
        _dataArray=dataArray;
        [self reloadData];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
