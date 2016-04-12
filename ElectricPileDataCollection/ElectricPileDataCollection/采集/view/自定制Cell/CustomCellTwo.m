//
//  CustomCellTwo.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CustomCellTwo.h"

@implementation CustomCellTwo

+ (instancetype)customCellWithTableView:(UITableView *)tableView{
    NSString * identifier=NSStringFromClass(self);
    CustomCellTwo * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        UINib * nib=[UINib nibWithNibName:identifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.descImageView.userInteractionEnabled=YES;
}


@end
