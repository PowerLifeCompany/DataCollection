//
//  CustomCellFour.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/26.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellFour : UITableViewCell

/**
 *  大(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *bnumTextField;

/**
 *  中(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *mnumTextField;

/**
 *  小(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *snumTextField;

/**
 *  微(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *wnumTextField;

+ (instancetype)customCellWithTableView:(UITableView *)tableView;

@end
