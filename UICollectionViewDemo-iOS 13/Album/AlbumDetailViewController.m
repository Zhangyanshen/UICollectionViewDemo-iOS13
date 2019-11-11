//
//  AlbumDetailViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/11.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "PhotoItemCollectionViewCell.h"
#import "UIImageView+YYWebImage.h"

@interface AlbumDetailViewController ()

@property (nonatomic, strong) NSArray *photos;

@end

@implementation AlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = @[
        @"http://img.jiaodong.net/pic/0/10/95/81/10958118_604510.jpg",
        @"https://b-ssl.duitang.com/uploads/item/201407/06/20140706222438_AV2dN.jpeg",
        @"https://b-ssl.duitang.com/uploads/item/201809/11/20180911180218_hklyi.jpg",
        @"http://i03.pictn.sogoucdn.com/a3922ed43d6d7027",
        @"http://i01.pictn.sogoucdn.com/400a032e4c831fb1",
        @"http://i03.pictn.sogoucdn.com/64a055f3497f295f",
        @"http://i04.pictn.sogoucdn.com/40778a743abae44a",
        @"http://i02.pictn.sogoucdn.com/a20381b4283dc77d",
        @"http://i01.pictn.sogoucdn.com/4120d236bb1627b3",
        @"http://00.imgmini.eastday.com/mobile/20180531/20180531120049_a82a43190cc4cf4e17ee880786e914c7_1.png",
        @"http://imgup04.iefans.net/iefans/2019-03/15/16/15526377496738_7.jpg",
        @"http://sports.sun0769.com/photo/composite/201303/W020130331542966530065.jpg",
        @"http://ztd00.photos.bdimg.com/ztd/w=350;q=70/sign=1d1c9b312f2dd42a5f0907ae33002a88/fd039245d688d43f4da25faa771ed21b0ef43b5b.jpg"
        ,
        @"http://pic.87g.com/upload/2018/0301/20180301021316192.jpg",
        @"https://img.cehca.com/uploadimg/ico/2019/1021/1571646577459981.jpg",
        @"http://b.hiphotos.baidu.com/zhidao/pic/item/3b292df5e0fe992535a1545f3ca85edf8db1710b.jpg"
        ,
        @"http://d.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=a2e684445b82b2b7a7ca31c2019de7d7/622762d0f703918fa34e218a533d269758eec4d6.jpg",
        @"https://b-ssl.duitang.com/uploads/item/201809/01/20180901124516_fconj.thumb.700_0.jpeg",
        @"http://img3.duitang.com/uploads/item/201501/01/20150101084426_sVcze.jpeg",
        @"http://pic22.photophoto.cn/20120113/0036036771604425_b.jpg",
        @"http://i04.pictn.sogoucdn.com/473008194fe06391",
        @"http://upload.mnw.cn/2014/1030/1414658148257.jpg",
        @"http://img0.pconline.com.cn/pconline/1808/14/11597744_584_2018081352737202_thumb.jpg",
        @"http://i01.pictn.sogoucdn.com/6e7a1bfdcb65926b",
        @"http://img.jiaodong.net/pic/0/10/95/81/10958118_604510.jpg",
    ];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PhotoItemCollectionViewCell class])];
}

#pragma mark - Setters/Getters

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoItemCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imgView yy_setImageWithURL:[NSURL URLWithString:self.photos[indexPath.item]] placeholder:nil];
    return cell;
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    // 1. Full photo
    NSCollectionLayoutSize *fullPhotoItemSize = [NSCollectionLayoutSize
                                                 sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                 heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:2.0/3.0]];
    NSCollectionLayoutItem *fullPhotoItem = [NSCollectionLayoutItem itemWithLayoutSize:fullPhotoItemSize];
    fullPhotoItem.contentInsets = NSDirectionalEdgeInsetsMake(2, 2, 2, 2);
    
    // 2. Main with pair
    // main item
    NSCollectionLayoutSize *mainItemSize = [NSCollectionLayoutSize
                                            sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:2.0/3.0]
                                            heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *mainItem = [NSCollectionLayoutItem itemWithLayoutSize:mainItemSize];
    mainItem.contentInsets = NSDirectionalEdgeInsetsMake(2, 2, 2, 2);
    // pair item
    NSCollectionLayoutSize *pairItemSize = [NSCollectionLayoutSize
                                            sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                            heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:0.5]];
    NSCollectionLayoutItem *pairItem = [NSCollectionLayoutItem itemWithLayoutSize:pairItemSize];
    pairItem.contentInsets = NSDirectionalEdgeInsetsMake(2, 2, 2, 2);
    // trailing group
    NSCollectionLayoutSize *trailingGroupSize = [NSCollectionLayoutSize
                                                 sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0/3.0]
                                                 heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutGroup *trailingGroup = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:trailingGroupSize subitem:pairItem count:2];
    // main with pair group
    NSCollectionLayoutSize *mainWithPairGroupSize = [NSCollectionLayoutSize
                                                     sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                     heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:4.0/9.0]];
    NSCollectionLayoutGroup *mainWithPairGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:mainWithPairGroupSize subitems:@[mainItem, trailingGroup]];
    // 3. Triplet
    NSCollectionLayoutSize *tripletItemSize = [NSCollectionLayoutSize
                                               sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0/3.0]
                                               heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *tripletItem = [NSCollectionLayoutItem itemWithLayoutSize:tripletItemSize];
    tripletItem.contentInsets = NSDirectionalEdgeInsetsMake(2, 2, 2, 2);
    
    NSCollectionLayoutSize *tripletGroupSize = [NSCollectionLayoutSize
                                                sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:2.0/9.0]];
    NSCollectionLayoutGroup *tripletGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:tripletGroupSize subitem:tripletItem count:3];
    
    // 4. Main with pair reverse
    NSCollectionLayoutGroup *mainWithPairReversedGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:mainWithPairGroupSize subitems:@[trailingGroup, mainItem]];

    // 5. Container group
    NSCollectionLayoutSize *containerGroupSize = [NSCollectionLayoutSize
                                                  sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                  heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:16.0/9.0]];
    NSCollectionLayoutGroup *containerGroup = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:containerGroupSize subitems:@[fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup]];
    
    // 6. Section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:containerGroup];
    
    // 7. layout
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
    
    return layout;
}

@end
