//
//  ViewController.m
//  PhotoWall
//
//  Created by AlterEgo on 25.03.14.
//  Copyright (c) 2014 Black. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController
int size;

- (void)viewDidLoad
{
    [super viewDidLoad];
    size = 1000000;
	// Do any additional setup after loading the view, typically from a nib.
    _scroll.contentSize = CGSizeMake(size, size);
    _scroll.contentOffset = CGPointMake(size/2,size/2);
    [self createStart];
    
//    _pointsArray = [[NSMutableArray alloc]init];
//    for (int i = 0;i < MAXFLOAT; i++) {
//        for (int j = 0; j<MAXFLOAT; j++) {
//            [_pointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(150 * i, 150 * j)]];
//        }
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createStart{
//    for (int i = 0; i < 4; i++) {
//        for (int j = 0; j < 4; j++) {
//            UIView * view = [[UIView alloc]init];
//            [view setBackgroundColor:[UIColor redColor]];
//            [view setFrame:CGRectMake(size/2+150*i, size/2+150*j, 150, 150)];
//            [_scroll addSubview:view];
//        }
//    }
//    _scroll.bounces = NO;
    _pointsArray = [[NSMutableArray alloc]init];
    _cellsArray = [[NSMutableArray alloc]init];
    [self setDataImagesForWatching];
}

// version 1.0
-(void)setDataImagesForWatching{

    int count = 0;
//    float pudding = 0;
//    int startPoint = size/2;


    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        stroke = 6;
        line = 10;
    } else {
        stroke = 4;
        line = 15;
    }


    for (int i = 0; i<stroke; i++) {

        for (int j = 0; j<line; j++) {
            
            CellVC * view = [[CellVC alloc] initWithNibName:@"CellVC" bundle:nil];
            [view.view setFrame:CGRectMake(size/2+150*i, size/2+150*j, 150, 150)];
            
            [_pointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(size/2+150*i, size/2+150*j)]];
            
            [view.view setBackgroundColor:[UIColor redColor]];
            [self.scrollView addSubview:view.view];
            [view.indicator startAnimating];
            [_cellsArray addObject:view];
            view.adjacentPoints = [view cellAdjacentPoints];
   
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
            [view.view addGestureRecognizer:singleTap];
            [view.view setUserInteractionEnabled:YES];
            [view.view setTag:iterator];

            iterator++;
            count++;
            if (count==60) {
                count = 0;
            }
        }
    }

    [self removePointsAfterAddElement];
    

    
    if (_firstTime) {
        conteiner_width = conteiner_width + 2250;
    }

    _firstTime = YES;
}

-(void)singleTapGestureCaptured:(id)sender{
     NSLog(@"TAP = %ld",(long)((UIViewController*)sender).view.tag);
}

-(void)removePointsAfterAddElement{
    // удаление базовых точек размещенных ячеек
    for (int k = 0; k<_pointsArray.count-1; k++) {
        for (int i =0; i<_cellsArray.count-1; i++) {
            CellVC * cell = _cellsArray[i];
            for (int j = 0; j<cell.adjacentPoints.count-1; j++) {
                CGPoint pointDelete = ((NSValue*)cell.adjacentPoints[j]).CGPointValue;
                CGPoint pointdata =((NSValue*)_pointsArray[k]).CGPointValue;
                if (CGPointEqualToPoint(pointDelete,pointdata)) {
                    [cell.adjacentPoints removeObject:(NSValue*)_pointsArray[k]];
                    
                }
            }
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"Scroll veloscity x = %f, y = %f",_scroll.contentOffset.x ,_scroll.contentOffset.y);
    CGRect screenRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, SCREEN_W, SCREEN_H);
    
    // проверка и добавление новых ячеек
    NSUInteger count = _cellsArray.count;
    if(_cellsArray!=NULL && count>0)
    for (int i = 0; i<count-1; i++) {
        CellVC *cell =(CellVC*)_cellsArray[i];
        NSMutableArray * cellarray = cell.adjacentPoints;
        for (int j = 0; j<cellarray.count-1;j++) {
            NSValue* pointValue = ((NSValue*)cellarray[j]);
            if (CGRectContainsPoint(screenRect,pointValue.CGPointValue)) {
                if (![_pointsArray containsObject:(NSValue*)cellarray[j]]) {
                    CellVC * viewPoint = [[CellVC alloc]init];
                    [viewPoint.view setFrame:CGRectMake(pointValue.CGPointValue.x,pointValue.CGPointValue.y, 150, 150)];
                    [viewPoint.view setBackgroundColor:[UIColor blackColor]];
                    viewPoint.view.tag = iterator;
                    // тестовая картинка
                    viewPoint.image.image = [UIImage imageNamed:@"test.jpg"];
                    viewPoint.adjacentPoints = [viewPoint cellAdjacentPoints];
                    
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                    [viewPoint.view addGestureRecognizer:singleTap];
                    [viewPoint.view setUserInteractionEnabled:YES];
                    [viewPoint.view setTag:iterator];
                    
                    iterator++;
                    [_pointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(pointValue.CGPointValue.x, pointValue.CGPointValue.y)]];
                    [_cellsArray addObject:viewPoint];
                    [self.scroll addSubview: viewPoint.view];
//                    [self removePointsAfterAddElement];
                    [self removePointFromArrays:pointValue.CGPointValue];
                }
            }
        }
    }
}

-(void)removePointFromArrays:(CGPoint)point{
    // удаление точек размещенных ячеек
    for (int j = 0; j<_cellsArray.count-1;j++) {
        CellVC* cell = _cellsArray[j];
        for (int i = 0; i<cell.adjacentPoints.count-1; i++) {
            if (CGPointEqualToPoint(point, ((NSValue*)cell.adjacentPoints[i]).CGPointValue)) {
                [cell.adjacentPoints removeObjectAtIndex:i];
            }
        }
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"Scroll veloscity x = %f, y = %f",_scroll.contentOffset.x ,_scroll.contentOffset.y);
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"Scroll veloscity x = %f, y = %f",targetContentOffset->x, targetContentOffset->y);
}

@end
