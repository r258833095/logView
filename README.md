logView
=======

辅助日志输出器

使用方法：
---------
在项目pch中加入宏
#define NSLog(...) dispatch_async(dispatch_get_main_queue(), ^{NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]);[[NSNotificationCenter defaultCenter]postNotificationName:@"logView" object:[NSString stringWithFormat:__VA_ARGS__]];});
