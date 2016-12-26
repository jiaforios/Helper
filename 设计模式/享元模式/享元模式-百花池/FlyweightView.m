//
//  FlyweightView.m
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "FlyweightView.h"
#import "FlowerView.h"

@implementation FlyweightView

extern NSString *FlowerObjectKey, *FlowerLocationKey;


- (void)drawRect:(CGRect)rect 
{
  for (NSDictionary *dic in self.flowerList)
  {
    
      NSValue *key = (NSValue *)[dic allKeys][0];
      FlowerView *flowerView = (FlowerView *)[dic allValues][0];
      CGRect area = [key CGRectValue];
      [flowerView drawRect:area];
  }

}

@end
