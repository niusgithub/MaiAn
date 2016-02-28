//
//  ZXSearchMenuView.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/11.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXSearchMenuView.h"
#import "TYGSelectMenu.h"
#import "TYGSelectMenuEntity.h"

@interface ZXSearchMenuView ()

@property (nonatomic, strong) UIButton *areaBtn;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) TYGSelectMenu *areaMenu;
@property (nonatomic, strong) TYGSelectMenu *titleMenu;

@property BOOL isOpen;

@end

@implementation ZXSearchMenuView

- (instancetype)initWithFrame:(CGRect)frame andType:(ZXSearchMenuType)type {
    if (self = [super initWithFrame:frame]) {
        
        self.type = type;
        
        self.isOpen = NO;
        
        CGFloat halfWight = frame.size.width / 2;
        
        // 地区按钮
        UIButton *areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        areaBtn.frame = CGRectMake(0, 0, halfWight - 0.5, frame.size.height);
        [areaBtn setTitle:@"地区" forState:UIControlStateNormal];
        [areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [areaBtn setTag:1];
        [areaBtn addTarget:self action:@selector(filterBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:areaBtn];
        self.areaBtn = areaBtn;
    
        // 中间分割线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(halfWight - 0.5, 5, 1, frame.size.height-10)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        // title按钮
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(halfWight + 0.5, 0, halfWight - 0.5, frame.size.height);
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTag:2];
        [titleBtn addTarget:self action:@selector(filterBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
        self.titleBtn = titleBtn;
        
        [self loadMenu];
    }
    return self;
}

- (void)loadMenu {
    
    NSArray *titleArr;
    switch (self.type) {
        case ZXSearchMenuDoctor: {
            [self.titleBtn setTitle:@"职称" forState:UIControlStateNormal];
            titleArr = @[@"主任医师", @"副主任医师", @"主治医师", @"医师"];
        }
            break;
            
        case ZXSearchMenuHospital: {
            [self.titleBtn setTitle:@"等级" forState:UIControlStateNormal];
            titleArr = @[@"三级甲等", @"三级乙等", @"二级甲等", @"二级乙等"];
        }
            break;
            
        default:
            [NSException exceptionWithName:@"初始化错误" reason:@"未初始化menu的type" userInfo:nil];
            break;
    }
    
    
    // Data from `city.json`
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *areaDicts = rootDict[@"area"];
    
    _areaMenu = [[TYGSelectMenu alloc] init];
    [areaDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TYGSelectMenuEntity *provinceMenu = [[TYGSelectMenuEntity alloc] init];
        provinceMenu.title = (NSString *)obj[@"province"];
        [_areaMenu addChildSelectMenu:provinceMenu forParent:nil];
        
        NSArray *cityDicts = obj[@"cities"];
        [cityDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TYGSelectMenuEntity *cityMenu = [[TYGSelectMenuEntity alloc] init];
            cityMenu.title = (NSString *)obj;
            [_areaMenu addChildSelectMenu:cityMenu forParent:provinceMenu];
        }];
    }];
    
    _titleMenu = [[TYGSelectMenu alloc] init];
    for (int i = 0; i < titleArr.count; i++) {
        TYGSelectMenuEntity *titleMenu = [[TYGSelectMenuEntity alloc] init];
        titleMenu.title = titleArr[i];
        [_titleMenu addChildSelectMenu:titleMenu forParent:nil];
    }
}

- (void)filterBtnOnClick:(UIButton *)sender {
    self.isOpen = !self.isOpen;
    
    switch (sender.tag) {
        case 1: {
            //显示并隐藏其它
            [self.areaMenu showFromView:sender];
            [self.titleMenu disMiss];
            
            //block回调
            [self.areaMenu selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                self.isOpen = NO;
                
                NSMutableString *area = [NSMutableString string];
                NSString *title;
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [area appendString:[NSString stringWithFormat:@"%@",tempMenu.title]];
                    title = tempMenu.title;
                }
                [sender setTitle:title forState:UIControlStateNormal];
                
                // 回调主界面更新数据
                if ([self.delegate respondsToSelector:@selector(updateDataByArea:)]) {
                    [self.delegate updateDataByArea:area];
                }
            }];
            break;
        }
        case 2: {
            //显示
            [self.titleMenu showFromView:sender];
            [self.areaMenu disMiss];
            
            //block回调
            [self.titleMenu selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                self.isOpen = NO;
                
                NSMutableString *title = [NSMutableString string];
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [title appendString:[NSString stringWithFormat:@"%@",tempMenu.title]];
                }
                [sender setTitle:title forState:UIControlStateNormal];
                // 回调主界面更新数据
                if ([self.delegate respondsToSelector:@selector(updateDataByTitle:)]) {
                    [self.delegate updateDataByTitle:title];
                }
            }];
            break;
        }
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isOpen) {
        return YES;
    } else {
        return CGRectContainsPoint(self.bounds, point);
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil) {
//        for (UIView *subView in self.subviews) {
//            for (UIView *sView in subView.subviews) { // 源码实现的不好 要重构
//                CGPoint tp = [sView convertPoint:point fromView:self];
//                if (CGRectContainsPoint(sView.bounds, tp)) {
//                    view = sView;
//                }
//            }
//        }
//    }
//    return view;
//}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"hitTest");
//    
//    UIView *touchView = self;
//    if ([self pointInside:point withEvent:event]) {
//        for (UIView *subView in self.subviews) {
//            //注意，这里有坐标转换，将point点转换到subview中，好好理解下
//            CGPoint subPoint = CGPointMake(point.x - subView.frame.origin.x, point.y - subView.frame.origin.y);
//            UIView *subTouchView = [subView hitTest:subPoint withEvent:event];
//            if (subTouchView) {
//                //找到touch事件对应的view，停止遍历
//                touchView = subTouchView;
//                break;
//            }
//        }
//    } else {
//        //此点不在该View中，那么连遍历也省了，直接返回nil
//        touchView = nil;
//    }
//    NSLog(@"hitTest:%@", touchView);
//    return touchView;
//}

@end
