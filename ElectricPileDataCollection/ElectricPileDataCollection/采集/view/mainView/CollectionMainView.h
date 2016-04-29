//
//  CollectionMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@class CollectionMainView;

@protocol CollectionMainViewDelegate <NSObject>

-(void)itemSelectedWithMainView:(CollectionMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

- (void)refreshWithMainView:(CollectionMainView *)mainView andRefreshComponent:(MJRefreshComponent *)baseView;

- (void)upLoadWithMainView:(CollectionMainView *)mainView andButtonNumber:(NSInteger)num;

@end

@interface CollectionMainView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,weak)id<CollectionMainViewDelegate>
mainViewDelegate;

@end