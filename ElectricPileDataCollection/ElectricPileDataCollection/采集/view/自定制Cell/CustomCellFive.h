//
//  CustomCellFive.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/26.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellFive : UITableViewCell

/**
 *  特殊说明
 */
@property (weak, nonatomic) IBOutlet UITextView *specialInstructionsTextView;

+ (instancetype)customCellWithTableView:(UITableView *)tableView;

@end
