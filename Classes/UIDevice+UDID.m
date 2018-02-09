//
//  UIDevice+UDID.m
//  KeyChain-UDID
//
//  Created by Rain on 2018/2/9.
//  Copyright © 2018年 YYQ. All rights reserved.
//

#import "UIDevice+UDID.h"


#define BundleID [NSBundle mainBundle].bundleIdentifier

@implementation UIDevice (UDID)

+ (NSString *)UDID {
    
    NSString *udid = (NSString *)[self getValueForKey:BundleID];
    if (udid.length == 0) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
        CFRelease(puuid);
        CFRelease(uuidString);
        [self saveValue:result forKey:BundleID];
        return result;
    }
    return udid;
}

+ (NSMutableDictionary *)keyChainDictionary:(NSString *)service {
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
                (id)kSecClassGenericPassword,(id)kSecClass,
                service,(id)kSecAttrService,
                service,(id)kSecAttrAccount,
                (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
                nil];
}

+ (void)saveValue:(id)data forKey:(NSString *)key {
    
    NSMutableDictionary *keyChainDictionary = [self keyChainDictionary:key];
    SecItemDelete((CFDictionaryRef)keyChainDictionary);
    [keyChainDictionary setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keyChainDictionary, NULL);
}


+ (id)getValueForKey:(NSString *)key {
    
    id value = nil;
    NSMutableDictionary *keyChainDictionary = [self keyChainDictionary:key];
    [keyChainDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChainDictionary, (CFTypeRef *)&keyData) == noErr) {
        @try {
            value = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *error) {
            
        } @finally {
            
        }
    }
    if (keyData)
    CFRelease(keyData);
    return value;
}


@end
