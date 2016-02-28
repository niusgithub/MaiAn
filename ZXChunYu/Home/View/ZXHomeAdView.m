//
//  ZXHomeAdView.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/8.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXHomeAdView.h"

#import "UIColor+ZX.h"
#import "NSTimer+ZXBlockSupport.h"
#import "ZXCommon.h"

#define ImageCount 3

@interface ZXHomeAdView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ZXHomeAdView 

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:_scrollView];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width/2-15, height-23, 30, 30)];
        [self addSubview:_pageControl];
        
        for (int i = 1; i < ImageCount + 1; i++) {
            CGFloat imageX = (i - 1) * width;
            CGFloat imageY = 0.f;
            UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(imageX, imageY, width, height)];
            [imageBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img_%02d", i]] forState:UIControlStateNormal];
            [imageBtn addTarget:self action:@selector(AdOnClick) forControlEvents:UIControlEventTouchUpInside];

            imageBtn.imageView.contentMode = UIViewContentModeScaleToFill;
            [self.scrollView addSubview:imageBtn];
        }
        
        self.scrollView.contentSize = CGSizeMake(ImageCount * width, 0);
        
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        // 拖动分页
        self.scrollView.pagingEnabled = YES;
        // 设置代理
        self.scrollView.delegate = self;
        // 设置总页数
        self.pageControl.numberOfPages = ImageCount;
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor themeColor];
        self.pageControl.pageIndicatorTintColor = ZXGrayColor;
        
        [self addScrollTimer];
    }
    return self;
}

- (void)AdOnClick {
    XZXLog(@"click!");
}

- (void)addScrollTimer
{
    // 创建定时器（两种方式：timerWithTimeInterval）
    // self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    self.timer = [NSTimer timerWithTimeInterval:5.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    __weak ZXHomeAdView *weakSelf = self;
    _timer = [NSTimer ZXScheduledTimerWithTimeInterval:5.f block:^{
        ZXHomeAdView *strongSelf = weakSelf;
        [strongSelf nextPage];
    } repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeScrollTimer
{
    [_timer invalidate];
    _timer = nil;
}

// 下一页
- (void)nextPage
{
    NSInteger currentPage = self.pageControl.currentPage;
    currentPage++;
    if (currentPage == 3) {
        currentPage = 0;
    }
    
    CGFloat width = self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(currentPage * width, 0.f);
    //    self.scrollView.contentOffset = offset;
    //    [self.scrollView setContentOffset:offset animated:YES];
    [UIView animateWithDuration:.2f animations:^{
        self.scrollView.contentOffset = offset;
    }];
    
}

#pragma mark - UIScrollViewDelegate
// scrollView滚动时执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger pageNum = (offsetX + .5f *  width) / width;
    
    self.pageControl.currentPage = pageNum;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeScrollTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addScrollTimer];
}


#pragma mark - dealloc

- (void)dealloc {
    [_timer invalidate];
}

@end

