//
//  TestVC1.m
//  CuiAnimationDemo
//
//  Created by 天下林子 on 2021/1/4.
//

#import "TestVC1.h"

@interface TestVC1 ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _cerateLayer];
    self.view.backgroundColor = [UIColor purpleColor];
    
}


- (void)_cerateLayer
{
    
 self.shapeLayer = ({
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  shapeLayer.bounds = CGRectMake(0, 0, 200, 200);
  //shapeLayer.bounds = self.view.bounds;
  shapeLayer.position = self.view.center;
  shapeLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
  shapeLayer.fillColor = [UIColor clearColor].CGColor;
  shapeLayer.strokeColor = [UIColor redColor].CGColor;
  shapeLayer.lineWidth = 3.f;
  shapeLayer;
 });
 
 [self.view.layer addSublayer:self.shapeLayer];
 //[self _teststrokeEnd];
 
}


#pragma mark - >>>>>>>>>>>>>>>
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 
 //[self test_strokeStar];
 //[self test_strokeEnd];
 [self _test2];
 return;
 
 //int random = random() / 10 ;
 
 //for (NSInteger i = 0; i < 3; i++) {
 
 CGFloat kWidth = self.shapeLayer.bounds.size.width / 2 ;
 CGFloat kHeight = self.shapeLayer.bounds.size.height / 2  ;
 NSLog(@"______%f", kWidth);
 
 //绘制动画
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:CGPointMake(kWidth, kHeight)];
 [path addLineToPoint:CGPointMake(kWidth,kHeight - 50)];
 //[path addLineToPoint:CGPointMake(kWidth, kHeight + 50)];
 self.shapeLayer.path = path.CGPath;
 
 CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
 strokeStartAnimation.fromValue = @0.5;
 strokeStartAnimation.toValue = @0;
 strokeStartAnimation.duration = 1.f;
 [self.shapeLayer addAnimation:strokeStartAnimation forKey:@"strokeStartAnimation"];
 
 UIBezierPath *path2 = [UIBezierPath bezierPath];
 [path2 moveToPoint:CGPointMake(kWidth, kHeight)];
 [path2 addLineToPoint:CGPointMake(kWidth, kHeight + 250)];
 self.shapeLayer.path = path.CGPath;
 
 
 CABasicAnimation *strokeStartAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
 strokeStartAnimation2.fromValue = @0.5;
 strokeStartAnimation2.toValue = @0;
 strokeStartAnimation2.duration = 1.f;
 [self.shapeLayer addAnimation:strokeStartAnimation2 forKey:@"strokeStartAnimation"];
 
 
 CAAnimationGroup *group = [CAAnimationGroup animation];
 group.animations = @[strokeStartAnimation2, strokeStartAnimation];
 group.duration = 1.0f;
 group.fillMode = kCAFillModeForwards;
 group.removedOnCompletion = NO;
 group.repeatCount = CGFLOAT_MAX;
 group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 [self.shapeLayer addAnimation:group forKey:@"groupAnimation"];
 //}
}

#pragma mark - test

- (void)_test2
{
 
 CGFloat kWidth = self.shapeLayer.bounds.size.width / 2 ;
 CGFloat kHeight = self.shapeLayer.bounds.size.height / 2  ;
 
 //绘制动画
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:CGPointMake(kWidth, kHeight)];
 [path addLineToPoint:CGPointMake(kWidth, kHeight - 50)];
 //[path addLineToPoint:CGPointMake(kWidth, kHeight + 50)];
 //self.shapeLayer.path = path.CGPath;
 
 /**
  start
  fromValue 1 到0  从无到有 然后逆时针画圆
  fromValue 0 到1 先出现一个完整的圆， 然后顺时针慢慢减少
  
  end
  fromValue 0 到1 从无到有，顺时针画圆
  fromValue 1 到0  先出现一个完整的圆，然后逆时针慢慢减少
  */
 
 CAShapeLayer *itemLine = self.shapeLayer;
 itemLine.path = [path CGPath];
 
 
 CGFloat animationTime = 0.25f;
 itemLine.strokeStart = 0.5;
 itemLine.strokeEnd = 0.5;
 
 CABasicAnimation *animationStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
 //fromValue 1 到0  从无到有 然后逆时针画圆
 animationStart.fromValue = @(0.5);
 animationStart.toValue = @(0.f);
 animationStart.duration = animationTime;
 
 CABasicAnimation *animationEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 //fromValue 0 到1 从无到有，顺时针画圆
 animationEnd.fromValue = @(0.5f);
 animationEnd.toValue = @(1.f);
 animationEnd.duration = animationTime;
 
 CABasicAnimation *animationStartZero = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
 //fromValue 0 到1 先出现一个完整的圆， 然后顺时针慢慢减少
 animationStartZero.fromValue = @(0.f);
 animationStartZero.toValue = @(0.5f);
 animationStartZero.beginTime = animationTime;
 animationStartZero.duration = animationTime;
 
 CABasicAnimation *animationEndZero = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 //fromValue 1 到0  先出现一个完整的圆，然后逆时针慢慢减少
 animationEndZero.fromValue = @(1.f);
 animationEndZero.toValue = @(0.5f);
 animationEndZero.beginTime = animationTime;
 animationEndZero.duration = animationTime;
 
 CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
 groupAnimation.duration = animationTime * 2;
 groupAnimation.animations = @[animationStart,animationEnd,animationStartZero,animationEndZero];
 groupAnimation.fillMode = kCAFillModeForwards;
 groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
 groupAnimation.removedOnCompletion = NO;
 groupAnimation.autoreverses = NO;
 groupAnimation.repeatCount = CGFLOAT_MAX;
 [itemLine addAnimation:groupAnimation forKey:@"itemLineLayerAnimation"];
 
}
- (void)_test
{
 CGFloat kWidth = self.shapeLayer.bounds.size.width / 2 ;
 CGFloat kHeight = self.shapeLayer.bounds.size.height / 2  ;
 
 //绘制动画
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:CGPointMake(kWidth, kHeight)];
 [path addLineToPoint:CGPointMake(kWidth, kHeight - 50)];
 [path addLineToPoint:CGPointMake(kWidth, kHeight + 150)];
 self.shapeLayer.path = path.CGPath;
 
 /**
  start
  fromValue 1 到0  从无到有 然后逆时针画圆
  fromValue 0 到1 先出现一个完整的圆， 然后顺时针慢慢减少
  
  end
  fromValue 0 到1 从无到有，顺时针画圆
  fromValue 1 到0  先出现一个完整的圆，然后逆时针慢慢减少
  */
 CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
 startAnimation.duration = 2.0f;
 startAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
 startAnimation.fromValue = [NSNumber numberWithFloat:1.0];
 startAnimation.toValue = [NSNumber numberWithFloat:0.0];
 
 startAnimation.fillMode = kCAFillModeForwards;
 startAnimation.removedOnCompletion = NO;
 [self.shapeLayer addAnimation:startAnimation forKey:@"strokeStartAnimation"];
 
 
 CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 endAnimation.duration = 2.0f;
 endAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
 endAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
 endAnimation.toValue = [NSNumber numberWithFloat:1.0f];
 startAnimation.fillMode = kCAFillModeForwards;
 startAnimation.removedOnCompletion = NO;
 [self.shapeLayer addAnimation:startAnimation forKey:@"strokeEndAnimation"];
 
 
 //--
 CAAnimationGroup *group = [CAAnimationGroup animation];
 group.animations = @[startAnimation, endAnimation];
 group.duration = 2.0f;
 group.fillMode = kCAFillModeForwards;
 group.removedOnCompletion = NO;
 group.repeatCount = CGFLOAT_MAX;
 group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

 [self.shapeLayer addAnimation:group forKey:@"groupAnimation"];
 
}



- (void)test_strokeStar
{
 CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 shapeLayer.frame = self.shapeLayer.bounds;
 
 UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.bounds];
 
 shapeLayer.path = path.CGPath;
 
 shapeLayer.fillColor = [UIColor clearColor].CGColor;
 shapeLayer.lineWidth = 2.0f;
 shapeLayer.strokeColor = [UIColor redColor].CGColor;
 
 [self.shapeLayer addSublayer:shapeLayer];
 
 /** 注释
  strokeStart 把一个圆先画完，然后 再慢慢减少
  strokeEnd 从原点开始画，然后把圆画完整
  */

 CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
 pathAnima.duration = 3.0f;
 pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 /** fromValue 0 到1 先出现一个完整的圆， 然后顺时针慢慢减少  */
//    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];

 /** fromValue 1 到0  从无到有 然后逆时针画圆  */
 pathAnima.fromValue = [NSNumber numberWithFloat:1.0f];
 pathAnima.toValue = [NSNumber numberWithFloat:0.0f];

 pathAnima.fillMode = kCAFillModeForwards;
 pathAnima.removedOnCompletion = NO;
 pathAnima.repeatCount = CGFLOAT_MAX;
 [shapeLayer addAnimation:pathAnima forKey:@"strokeStartAnimation"];
}

- (void)test_strokeEnd
{
 CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 shapeLayer.frame = self.shapeLayer.bounds;
 
 UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.bounds];
 
 shapeLayer.path = path.CGPath;
 
 shapeLayer.fillColor = [UIColor clearColor].CGColor;
 shapeLayer.lineWidth = 2.0f;
 shapeLayer.strokeColor = [UIColor redColor].CGColor;
 
 [self.shapeLayer addSublayer:shapeLayer];
 
 /** 注释
  strokeStart 把一个圆先画完，然后 再慢慢减少
  strokeEnd 从原点开始画，然后把圆画完整
  */
 
 CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 pathAnima.duration = 3.0f;
 pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 
 /** fromValue 0 到1 从无到有，顺时针画圆  */
 pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
 pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
 
 /** fromValue 1 到0  先出现一个完整的圆，然后逆时针慢慢减少  */
//    pathAnima.fromValue = [NSNumber numberWithFloat:1.0f];
//    pathAnima.toValue = [NSNumber numberWithFloat:0.0f];

 pathAnima.fillMode = kCAFillModeForwards;
 pathAnima.removedOnCompletion = NO;
 pathAnima.repeatCount = CGFLOAT_MAX;
 [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
 
 
}




@end
