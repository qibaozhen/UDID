以bundleID 为key 保存uuid 到 keychain， 作为设备唯一识别码

使用方法

1.pod 'UDID'

2.pod update

3. #import <UIDevice+UDID.h>

4. NSString *UDID =[UIDevice UDID];


