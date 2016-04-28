//
//  PileInfoMainView.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PileInfoMainView;

@protocol PileInfoMainViewDelegate <NSObject>

- (void)itemSelectedWithMainView:(PileInfoMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

@end

@interface PileInfoMainView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<PileInfoMainViewDelegate>mainViewDelegate;

@property (strong, nonatomic) NSMutableArray * dataArray;

@end
