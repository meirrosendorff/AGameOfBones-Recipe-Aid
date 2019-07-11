//
//  LoginViewModelProtocol.m
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/10.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginViewModelProtocol
  @required
  @property(nonatomic, readonly) Boolean isLoggedIn;
- (void) loginForUser:(NSString*)username withPassword:(NSString*)password onComplete:(void (^)(Boolean))onComplete;
@end
