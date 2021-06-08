#import <Foundation/Foundation.h>

// c 语言的枚举
typedef enum
{
    JanC = 1,
    FebC = 2,
    MarC = 3
} WMonthC;

// oc 语言的枚举
enum WMonthOC
{
    JanOC = 1,
    FebOC = 2,
    MarOC = 3
};



// NS_OPTIONS ？
typedef NS_OPTIONS(NSUInteger, YYAbc) {
    YYAbc1 = 1,
    YYAbc2 = 2
};