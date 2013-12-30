//
//  logView.m
//  
//
//  Created by UIBear.com on 13-12-29.
//  Copyright (c) 2013年 UIBear.com. All rights reserved.
//

#import "logView.h"

@implementation logView{
    
    UITextView *txtView;
    
    CGFloat xOffSet;
    CGFloat yOffSet;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFrame:CGRectMake(43, 75, 255, 150)];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.75]];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitle:@"x" forState:UIControlStateNormal];
        [btn setContentMode:UIViewContentModeCenter];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setSelected:YES];
        [self addSubview:btn];
        
        UIButton *cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(255-45, 0, 45, 30)];
        [cleanBtn setBackgroundColor:[UIColor grayColor]];
        [cleanBtn setTitle:@"clean" forState:UIControlStateNormal];
        [cleanBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cleanBtn setContentMode:UIViewContentModeCenter];
        [cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cleanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cleanBtn];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.text = @"辅助日志输出器";
        lbl.textColor = [UIColor whiteColor];
        lbl.backgroundColor = [UIColor clearColor];
        [self addSubview:lbl];
        
        txtView = [[UITextView alloc]initWithFrame:CGRectMake(0, 30,
                                                              self.frame.size.width,
                                                              self.frame.size.height-30)];
        [txtView setText:@"All Output :"];
        [txtView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
        [txtView setTextColor:[UIColor blackColor]];
        [txtView setEditable:NO];
        [self addSubview:txtView];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(viewControl:) name:@"logView" object:nil];
        
        [self setAlpha:0];
        
    }
    return self;
}


#pragma mark - btn Action
- (void)btnAction:(UIButton*)sender{
    
    sender.selected =! sender.selected;
    
    if (sender.selected) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 255, 150);
        txtView.hidden = NO;
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 255, 30);
        txtView.hidden = YES;
    }
}


- (void)cleanAction{
    
    [txtView setText:@"All Output :"];

}
#pragma mark - notification
- (void)viewControl:(NSNotification*)notification{
    
    [UIView animateWithDuration:0.5 animations:^(void){
        if ([[notification object]isEqualToString:@"+show+"]) {
            [self setAlpha:1];
        }else if ([[notification object]isEqualToString:@"-hide-"]){
            [self setAlpha:0];
        }else{
            txtView.text = [txtView.text stringByAppendingFormat:@"\n\n%@",[notification object]];
        }
    }];
    
   
    
}

#pragma mark - view touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    xOffSet=touchPoint.x- [touch view].frame.origin.x;
    yOffSet=touchPoint.y- [touch view].frame.origin.y;

}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    [touch view].frame = CGRectMake(touchPoint.x-xOffSet,
                                    touchPoint.y-yOffSet,
                                    [touch view].frame.size.width,
                                    [touch view].frame.size.height);

}

@end
