//
//  FlowerFactory.h
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
  kAnemone,
  kCosmos,
  kGerberas,
  kHollyhock,
  kJasmine,
  kZinnia,
  kTotalNumberOfFlowerTypes
} FlowerType;

@interface FlowerFactory : NSObject 
{
  @private
  NSMutableDictionary *flowerPool_;
}

- (UIImageView *) flowerViewWithType:(FlowerType)type;

@end
