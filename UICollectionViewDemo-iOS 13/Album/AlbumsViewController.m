//
//  AlbumsViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/12.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "AlbumsViewController.h"
#import "Album1CollectionViewCell.h"
#import "Album2CollectionViewCell.h"
#import "AlbumHeaderCollectionReusableView.h"
#import "UIImageView+YYWebImage.h"
#import "AlbumDetailViewController.h"

@interface AlbumsViewController ()

@property (nonatomic, strong) NSArray *albums;

@end

@implementation AlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.albums = @[
        @{@"headerTitle": @"相册集1", @"albums": @[
            @{@"title": @"相册1-1", @"url": @"http://img.jiaodong.net/pic/0/10/95/81/10958118_604510.jpg"},
            @{@"title": @"相册1-2", @"url": @"https://b-ssl.duitang.com/uploads/item/201407/06/20140706222438_AV2dN.jpeg"},
            @{@"title": @"相册1-3", @"url": @"https://b-ssl.duitang.com/uploads/item/201809/11/20180911180218_hklyi.jpg"},
        ]},
        @{@"headerTitle": @"相册集2", @"albums": @[
            @{@"title": @"相册2-1", @"url": @"http://i03.pictn.sogoucdn.com/a3922ed43d6d7027"},
            @{@"title": @"相册2-2", @"url": @"http://i01.pictn.sogoucdn.com/400a032e4c831fb1"},
            @{@"title": @"相册2-3", @"url": @"http://i03.pictn.sogoucdn.com/64a055f3497f295f"},
        ]},
        @{@"headerTitle": @"相册集3", @"albums": @[
            @{@"title": @"相册3-1", @"url": @"http://i04.pictn.sogoucdn.com/40778a743abae44a"},
            @{@"title": @"相册3-2", @"url": @"http://i02.pictn.sogoucdn.com/a20381b4283dc77d"},
            @{@"title": @"相册3-3", @"url": @"http://i01.pictn.sogoucdn.com/4120d236bb1627b3"},
            @{@"title": @"相册3-4", @"url": @"http://sports.sun0769.com/photo/composite/201303/W020130331542966530065.jpg"},
            @{@"title": @"相册3-5", @"url": @"http://pic.87g.com/upload/2018/0301/20180301021316192.jpg"},
            @{@"title": @"相册3-6", @"url": @"https://img.cehca.com/uploadimg/ico/2019/1021/1571646577459981.jpg"},
        ]},
    ];
    [self.collectionView registerNib:[UINib nibWithNibName:@"Album1CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([Album1CollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"Album2CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([Album2CollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AlbumHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:@"header" withReuseIdentifier:NSStringFromClass([AlbumHeaderCollectionReusableView class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.albums.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *album = self.albums[section];
    return [album[@"albums"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *albums = self.albums[indexPath.section];
    NSDictionary *album = albums[@"albums"][indexPath.item];
    switch (indexPath.section) {
        case 0:
        case 1:
        {
            Album1CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([Album1CollectionViewCell class]) forIndexPath:indexPath];
            cell.albumTitleLabel.text = album[@"title"];
            [cell.imgView yy_setImageWithURL:[NSURL URLWithString:album[@"url"]] placeholder:nil];
            return cell;
        }
            break;
        case 2:
        {
            Album2CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([Album2CollectionViewCell class]) forIndexPath:indexPath];
            cell.albumTitleLabel.text = album[@"title"];
            [cell.imgView yy_setImageWithURL:[NSURL URLWithString:album[@"url"]] placeholder:nil];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    AlbumHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:@"header" withReuseIdentifier:NSStringFromClass([AlbumHeaderCollectionReusableView class]) forIndexPath:indexPath];
    NSDictionary *album = self.albums[indexPath.section];
    header.headerTitleLabel.text = album[@"headerTitle"];
    return header;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumDetailViewController *detailVC = [[AlbumDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger section, id<NSCollectionLayoutEnvironment> _Nonnull layoutEnvironment) {
        NSCollectionLayoutSection *layoutSection = nil;
        BOOL isWideView = layoutEnvironment.container.effectiveContentSize.width > 500;
        switch (section) {
            case 0:
                layoutSection = [self generateAlbum1LayoutSectionWithWideMode:isWideView];
                break;
            case 1:
                layoutSection = [self generateAlbum2LayoutSectionWithWideMode:isWideView];
                break;
            case 2:
                layoutSection = [self generateAlbum3LayoutSectionWithWideMode:isWideView];
                break;
        }
        NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize
                                              sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                              heightDimension:[NSCollectionLayoutDimension absoluteDimension:44]];
        NSCollectionLayoutBoundarySupplementaryItem *header = [NSCollectionLayoutBoundarySupplementaryItem
                                                               boundarySupplementaryItemWithLayoutSize:headerSize
                                                               elementKind:@"header"
                                                               alignment:NSRectAlignmentTop];
        layoutSection.boundarySupplementaryItems = @[header];
        return layoutSection;
    }];
    return layout;
}

- (NSCollectionLayoutSection *)generateAlbum1LayoutSectionWithWideMode:(BOOL)isWide {
    // item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize
                                    sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                    heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    // group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize
                                         sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:isWide ? 0.475 : 0.95]
                                         heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:isWide ? 1.0/3.0 : 2.0/3.0]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup
                                      horizontalGroupWithLayoutSize:groupSize
                                      subitem:item
                                      count:1];
    group.contentInsets = NSDirectionalEdgeInsetsMake(5, 5, 5, 5);
    // section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;
    
    return section;
}

- (NSCollectionLayoutSection *)generateAlbum2LayoutSectionWithWideMode:(BOOL)isWide {
    // item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize
                                        sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                        heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    // group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize
                                          sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:isWide ? 280 : 140]
                                          heightDimension:[NSCollectionLayoutDimension absoluteDimension:isWide ? 360 : 180]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup
                                      horizontalGroupWithLayoutSize:groupSize
                                      subitem:item
                                      count:1];
    group.contentInsets = NSDirectionalEdgeInsetsMake(5, 5, 5, 5);
    // section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;
    
    return section;
}

- (NSCollectionLayoutSection *)generateAlbum3LayoutSectionWithWideMode:(BOOL)isWide {
    // item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize
                                        sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                        heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    item.contentInsets = NSDirectionalEdgeInsetsMake(4, 4, 4, 4);
    // group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize
                                         sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                         heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:isWide ? 1.0/3.0 : 1.0/2.0]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup
                                      horizontalGroupWithLayoutSize:groupSize
                                      subitem:item
                                      count:isWide ? 3 : 2];
    // section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    
    return section;
}

@end
