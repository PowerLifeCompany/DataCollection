//
//  CollPileMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollPileMainView;


@protocol CollPileMainViewDelegate <NSObject>

- (void)itemSelectedWithMainView:(CollPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

@end


@interface CollPileMainView : UITableView<UITableViewDelegate>

@property(nonatomic,strong)NSArray * villageDataArray;

@property (nonatomic, weak)UIImageView * currentImageView;

@property(nonatomic,weak)id<CollPileMainViewDelegate> mainViewDelegate;

@end
