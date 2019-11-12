//
//  Album2CollectionViewCell.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/12.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "Album2CollectionViewCell.h"

@implementation Album2CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.albumTitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.albumTitleLabel.layer.shadowOffset = CGSizeMake(4, 4);
    self.albumTitleLabel.layer.shadowRadius = 3.0;
    self.albumTitleLabel.layer.shadowOpacity = 1.0;
    self.albumTitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end
