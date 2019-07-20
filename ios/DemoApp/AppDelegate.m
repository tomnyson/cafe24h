// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import <AppCenterReactNative/AppCenterReactNative.h>
#import <AppCenterReactNativeAuth/AppCenterReactNativeAuth.h>
#import <AppCenterReactNativePush/AppCenterReactNativePush.h>
#import <AppCenterReactNativeCrashes/AppCenterReactNativeCrashes.h>
#import <AppCenterReactNativeAnalytics/AppCenterReactNativeAnalytics.h>
#import <AppCenterReactNativeShared/AppCenterReactNativeShared.h>

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
@import AppCenter;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [MSAppCenter setLogLevel: MSLogLevelVerbose];
  
  id appSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppSecret"];
  if ([appSecret isKindOfClass:[NSString class]]) {
    [AppCenterReactNativeShared setAppSecret:appSecret];
  }
  
  id startAutomatically = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartAutomatically"];
  if ([startAutomatically isKindOfClass:[NSNumber class]]) {
    [AppCenterReactNativeShared setStartAutomatically:[startAutomatically boolValue]];
  }

  [AppCenterReactNativeAuth register];  // Initialize AppCenter auth

  [AppCenterReactNative register];  // Initialize AppCenter 

  [AppCenterReactNativePush register];  // Initialize AppCenter push

  [AppCenterReactNativeCrashes register];  // Initialize AppCenter crashes

  [AppCenterReactNativeAnalytics registerWithInitiallyEnabled:true];  // Initialize AppCenter analytics

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"DemoApp"
                                            initialProperties:nil];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
