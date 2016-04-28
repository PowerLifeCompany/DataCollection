//
//  CustomCellFive.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/26.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CustomCellFive.h"

@implementation CustomCellFive

+ (instancetype)customCellWithTableView:(UITableView *)tableView
{
    NSString *identifier = NSStringFromClass(self);
    CustomCellFive *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
