//
//  Album2CollectionViewCell.h
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/12.
//  Copyright © 2019 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Album2CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;

@end

NS_ASSUME_NONNULL_END
