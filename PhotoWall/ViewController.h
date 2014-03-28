//
//  ViewController.h
//  PhotoWall
//
//  Created by AlterEgo on 25.03.14.
//  Copyright (c) 2014 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellVC.h"
#define SCREEN_H [ [ UIScreen mainScreen ] bounds ].size.height
#define SCREEN_W [ [ UIScreen mainScreen ] bounds ].size.width

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    int conteiner_width;
    int conteiner_height;
    int iterator;
    int countRequest;
    int stroke;
    int line;
}
@property(nonatomic)        BOOL firstTime;
@property(nonatomic)        BOOL firstShow;
@property(nonatomic,strong) NSMutableArray * cellsArray;
@property(nonatomic,strong) id delegate;
@property(nonatomic,strong) IBOutlet UIView * mainView;
@property(nonatomic,strong) IBOutlet UIScrollView * scrollView;
@property(nonatomic,strong) IBOutlet UIView * contentView;
@property(nonatomic,strong) NSMutableArray * dataArray;

@property(nonatomic, strong) IBOutlet UIScrollView *scroll;
@property(nonatomic, strong) NSMutableArray * pointsArray;

@end
