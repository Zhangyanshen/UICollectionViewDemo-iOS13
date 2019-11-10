//
//  DecorateCollectionReusableView.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/10.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "DecorateCollectionReusableView.h"

@implementation DecorateCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

@end
