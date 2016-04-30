//
//  ChargeStandardMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingChargeStandard.h"
@class ChargeStandardMainView;

@protocol ChargeStandardMainViewDelegate <NSObject>

- (void)pushNextVC;

- (void)itemSelectedWithMainView:(ChargeStandardMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

@end

@interface ChargeStandardMainView : UITableView

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,weak)id<ChargeStandardMainViewDelegate> mainViewDelegate;

@property (strong, nonatomic) UIView *footerView;

@end
