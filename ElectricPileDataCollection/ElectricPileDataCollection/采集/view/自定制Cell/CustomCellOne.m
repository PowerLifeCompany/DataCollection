//
//  CustomCellOne.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CustomCellOne.h"

@implementation CustomCellOne


+ (instancetype)customCellWithTableView:(UITableView *)tableView{
    NSString * identifier=NSStringFromClass(self);
    CustomCellOne * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        UINib * nib=[UINib nibWithNibName:identifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.categoryLabel.text=@"";
    self.contentLabel.text=@"";
    self.contentLabel.font = [UIFont systemFontOfSize:14.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
