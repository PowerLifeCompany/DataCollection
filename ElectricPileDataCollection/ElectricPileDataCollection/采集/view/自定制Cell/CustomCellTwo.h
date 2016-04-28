//
//  CustomCellTwo.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellTwo : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *descImageView;

@property (weak, nonatomic) IBOutlet UITextView *descTextView;

+ (instancetype)customCellWithTableView:(UITableView *)tableView;

@end
