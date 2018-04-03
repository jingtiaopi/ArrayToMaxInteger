//
//  main.m
//  ArrayToInteger
//
//  Created by TP on 2018/4/2.
//  Copyright © 2018年 TP. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kCoverString = @"a";
static NSString *const kReplaceString = @"9";

//获取Array 中的最大位 位数
NSInteger getArrayHighestOrder(NSArray *array)
{
    __block NSInteger highestOrder = 1;
    [array enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%ld", (long)obj.integerValue];
        NSInteger tempLength = string.length;
        if (tempLength > highestOrder)
        {
            highestOrder = tempLength;
        }
    }];
    return highestOrder;
}

NSMutableString * coverString(NSNumber *number, NSInteger arrayHighestOrder)
{
    NSString *string = [NSString stringWithFormat:@"%ld", (long)number.integerValue];
    NSInteger arrayILength = [string length];
    NSMutableString *mString = [NSMutableString stringWithString:string];
    if (arrayILength < arrayHighestOrder)
    {
        while ((arrayHighestOrder - arrayILength) > 0)
        {
            [mString appendString:kCoverString];
            arrayILength = [mString length];
        }
    }
    return mString;
}

NSString * getMaxIntegerWithRemoveCoverString(NSMutableArray *mArray)
{
    NSString *string = [mArray componentsJoinedByString:@""];
    NSString *resultString = [string stringByReplacingOccurrencesOfString:kCoverString withString:@""];
    return resultString;
}

//给出一个存放NSInteger的数组，要求对数组中的数据进行拼接，输出一个最大NSInteger数据
NSString * getMaxIntegerFromArray(NSArray *array)
{
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
    NSInteger arrayHighestOrder = getArrayHighestOrder(array);
    
    //做判断前，先对数据进行补位
    for (int i = 0; i < mArray.count; i++)
    {
        mArray[i] = coverString(mArray[i], arrayHighestOrder);
    }
    NSInteger tempArrayHighestOrder = arrayHighestOrder;
    while (arrayHighestOrder--)
    {
        for (int i = 0; i < mArray.count - 1; i++)
        {
            NSInteger maxIntegerIndex = i;
            for (int j = i + 1; j < mArray.count; j++)
            {
                NSString *tempMaxValue = [mArray[maxIntegerIndex] substringWithRange:NSMakeRange(0, tempArrayHighestOrder - arrayHighestOrder)];
                NSMutableString *tempMaxValueMString = [NSMutableString stringWithString:tempMaxValue];
                if ([tempMaxValue rangeOfString:kCoverString].location != NSNotFound)
                {
                    tempMaxValueMString = [tempMaxValue mutableCopy];
                    tempMaxValueMString = (NSMutableString *)[tempMaxValueMString stringByReplacingOccurrencesOfString:kCoverString withString:kReplaceString];
                }
                
                NSString *tempJValue = [mArray[j] substringWithRange:NSMakeRange(0, tempArrayHighestOrder - arrayHighestOrder)];
                NSMutableString *tempJValueMString = [NSMutableString stringWithString:tempJValue];
                if ([tempJValue rangeOfString:kCoverString].location != NSNotFound)
                {
                    tempJValueMString = [tempJValue mutableCopy];
                    tempJValueMString = (NSMutableString *)[tempJValueMString stringByReplacingOccurrencesOfString:kCoverString withString:kReplaceString];
                }
                if (tempMaxValueMString.integerValue < tempJValueMString.integerValue)
                {
                    maxIntegerIndex = j;
                }
            }
            [mArray exchangeObjectAtIndex:i withObjectAtIndex:maxIntegerIndex];
        }
    }
    NSLog(@"需要组成最大数，排序后的数组：%@", mArray);
    return getMaxIntegerWithRemoveCoverString(mArray);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *array = @[@9, @80, @35, @53, @52, @59, @94, @98, @978, @987, @63, @100, @10, @23, @333, @323, @8, @88, @986];
        NSLog(@"%@", getMaxIntegerFromArray(array));
    }
    return 0;
}
/*
 1、先获取数组中所有数据的最高位的位数，之后将不足该位数的数据补a补全位数
 2、从最高位开始，从大到小排序，之后前两位进行比较排序，前三位、前四位... 其中单位数a最大（比较时，可将a再提换成9进行比较）
 4、按排序后的数组进行@""的拼接，去除数据中的补全数a，输出最大数
 */





