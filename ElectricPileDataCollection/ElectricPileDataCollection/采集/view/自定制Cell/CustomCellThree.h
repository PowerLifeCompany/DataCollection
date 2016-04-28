//
//  CustomCellThree.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/26.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellThree : UITableViewCell

/**
 *  位置
 */
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

/**
 *  经度
 */
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

/**
 *  纬度
 */
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;


+ (instancetype)customCellWithTableView:(UITableView *)tableView;

@end
