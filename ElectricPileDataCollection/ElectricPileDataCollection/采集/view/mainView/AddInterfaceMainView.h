//
//  AddInterfaceMainView.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddInterfaceMainView;

@protocol AddInterfaceMainViewDelegate <NSObject>

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

- (void)chooseTakeChargingType:(AddInterfaceMainView *)mainView;

- (void)choosePayType:(AddInterfaceMainView *)mainView payTypeTap:(UITapGestureRecognizer *)tap;

@end


@interface AddInterfaceMainView : UITableView<UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>
/**
 *  接口类型
 */
@property (weak, nonatomic) IBOutlet UILabel *interfaceTypeLabel;


/**
 *  服务费
 */
@property (weak, nonatomic) IBOutlet UITextField *serviceFeeTextField;

/**
 *  电桩是否自带充电线
 */

@property (assign, nonatomic) BOOL isTakeChargingLine;

@property (copy, nonatomic) NSString *takeChargingType;

@property (weak, nonatomic) IBOutlet UIImageView *takeCharingTypeYesImageView;

@property (weak, nonatomic) IBOutlet UIImageView *takeCharingTypeNoImageView;

/**
 *  接口个数
 */
@property (weak, nonatomic) IBOutlet UITextField *interfaceNumTextField;

/**
 *  重量
 */
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;

/**
 *  电压-A
 */
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;

/**
 *  电压-V
 */
@property (weak, nonatomic) IBOutlet UITextField *voltageTextField;

/**
 *  忙时-开始时间
 */
@property (weak, nonatomic) IBOutlet UITextField *busyStartTextField;

/**
 *  忙时-结束时间
 */
@property (weak, nonatomic) IBOutlet UITextField *busyEndTextField;

/**
 *  忙时-价格
 */
@property (weak, nonatomic) IBOutlet UITextField *busyPriceTextField;

/**
 *  闲时-开始时间
 */
@property (weak, nonatomic) IBOutlet UITextField *idleStartTextField;

/**
 *  闲时-结束时间
 */
@property (weak, nonatomic) IBOutlet UITextField *idleEndTextField;

/**
 *  闲时-价格
 */
@property (weak, nonatomic) IBOutlet UITextField *idlePriceTextField;

/**
 *  支付方式
 */
@property (copy, nonatomic) NSString* payType;

@property (assign, nonatomic) BOOL isChoosepayOpetator;

@property (assign, nonatomic) BOOL isChoosepayWechat;

@property (assign, nonatomic) BOOL isChoosepayAli;

@property (assign, nonatomic) BOOL isChoosepayCreditCard;

@property (weak, nonatomic) IBOutlet UIImageView *payOpetator;

@property (weak, nonatomic) IBOutlet UIImageView *payWechat;

@property (weak, nonatomic) IBOutlet UIImageView *payAli;

@property (weak, nonatomic) IBOutlet UIImageView *payCreditCard;

/**
 *  充电口正面照
 */
@property (weak, nonatomic) IBOutlet UIImageView *interfaceImageView;

/**
 *  充电口正面照文字描述
 */
@property (weak, nonatomic) IBOutlet UITextView *interfaceTextView;

/**
 *  充电把，细节特写 照片
 */
@property (weak, nonatomic) IBOutlet UIImageView *interfaceDetailsImageView;

/**
 *  充电把，细节特写 文字描述
 */
@property (weak, nonatomic) IBOutlet UITextView *interfaceDetailTextView;

/**
 *  特殊说明
 */
@property (weak, nonatomic) IBOutlet UITextView *instructionsTextView;

@property (weak, nonatomic) id<AddInterfaceMainViewDelegate>mainViewDelegate;

@property (nonatomic, weak)UIImageView * currentImageView;

@end