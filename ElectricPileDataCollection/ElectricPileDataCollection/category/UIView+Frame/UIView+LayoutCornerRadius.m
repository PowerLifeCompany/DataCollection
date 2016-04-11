//
//  UIView+LayoutCornerRadius.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "UIView+LayoutCornerRadius.h"

@implementation UIView (LayoutCornerRadius)

- (void)layoutCornerRadiusWithCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=cornerRadius;
}

@end
