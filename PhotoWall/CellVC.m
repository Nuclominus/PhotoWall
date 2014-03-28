//
//  CellVC.m
//  PhotoWall
//
//  Created by AlterEgo on 27.03.14.
//  Copyright (c) 2014 Black. All rights reserved.
//

#import "CellVC.h"

@interface CellVC ()

@end

@implementation CellVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (self) {
            self.image = [[UIImageView alloc]init];
            [_image setFrame:CGRectMake(0, 0, 150, 150)];
//            [_image setBackgroundColor:[UIColor redColor]];
            
            _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            [_indicator setColor:[UIColor blackColor]];
            [_indicator setFrame:CGRectMake(0,0, 30, 30)];
        }

    }
    return self;
}

-(NSMutableArray*)cellAdjacentPoints{
    if (_adjacentPoints==NULL) {
        _adjacentPoints = [[NSMutableArray alloc]init];
    }
    
    // 8 точек вокруг
    
    CGPoint point1 = CGPointMake(self.view.center.x+150, self.view.center.y);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point1]];
    
    CGPoint point2 = CGPointMake(self.view.center.x+150, self.view.center.y+150);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point2]];
    
    CGPoint point3 = CGPointMake(self.view.center.x, self.view.center.y+150);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point3]];
    
    CGPoint point4 = CGPointMake(self.view.center.x-150, self.view.center.y);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point4]];
    
    CGPoint point5 = CGPointMake(self.view.center.x, self.view.center.y-150);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point5]];
    
    CGPoint point6 = CGPointMake(self.view.center.x-150, self.view.center.y-150);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point6]];
    
    CGPoint point7 = CGPointMake(self.view.center.x-150, self.view.center.y+150);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point7]];
    
    CGPoint point8 = CGPointMake(self.view.center.x+150, self.view.center.y-150);
    [_adjacentPoints addObject:[NSValue valueWithCGPoint:point8]];
    
    return _adjacentPoints;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
