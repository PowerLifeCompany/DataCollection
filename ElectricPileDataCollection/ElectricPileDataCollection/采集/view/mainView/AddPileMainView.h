//
//  AddPileMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddPileMainView;

@protocol AddPileMainViewDelegate <NSObject>

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

- (void)itemSelectedWithMainView:(AddPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

- (void)addPileInterface:(AddPileMainView *)mainView;

@end

@interface AddPileMainView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,weak)UIImageView * currentImageView;

@property(nonatomic,weak)id<AddPileMainViewDelegate> mainViewDelegate;

@end
