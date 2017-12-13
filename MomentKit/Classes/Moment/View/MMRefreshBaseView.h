//
//  MMRefreshBaseView.h
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const MMRefreshObserveKeyPath;

typedef enum {
    MMRefreshHeadViewStateNormal,
    MMRefreshHeadViewStateWillRefresh,
    MMRefreshHeadViewStateRefreshing,
} MMRefreshHeadViewState;


@interface MMRefreshBaseView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) MMRefreshHeadViewState refreshState;

- (void)endRefreshing;

@end
