//
//  AddPileMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPileMainView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;

@end
