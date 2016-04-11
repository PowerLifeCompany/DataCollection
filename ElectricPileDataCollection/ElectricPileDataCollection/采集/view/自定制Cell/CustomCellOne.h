//
//  CustomCellOne.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellOne : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (instancetype)customCellWithTableView:(UITableView *)tableView;

@end
