//
//  PileInfoCell.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PileInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;


@end
