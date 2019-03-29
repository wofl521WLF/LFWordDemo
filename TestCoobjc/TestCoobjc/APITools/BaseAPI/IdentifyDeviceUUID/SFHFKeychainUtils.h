//
//  SFHFKeychainUtils.h
//
//  Created by Buzz Andersen on 10/20/08.
//  Based partly on code by Jonathan Wight, Jon Crosby, and Mike Malone.
//  Copyright 2008 Sci-Fi Hi-Fi. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>


@interface SFHFKeychainUtils : NSObject {
  
}

/**
 *	@brief	从Keychain里获取用户密码
 *
 *	@param 	username 	用户名
 *	@param 	serviceName 	App identifier
 *	@param 	error 	error
 *
 *	@return	用户名对应的密码
 */
+ (NSString *)getPasswordForUsername:(NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error;
/**
 *	@brief	把用户的密码保存到Keychain里
 *
 *	@param 	username 	用户名
 *	@param 	password 	要保存的密码
 *	@param 	serviceName 	App identifier
 *	@param 	updateExisting 	是否覆盖已经写入到KeyChain里面值
 *	@param 	error 	error
 *
 *	@return	是否存储成功
 */
+ (BOOL)storeUsername:(NSString *)username andPassword:(NSString *)password forServiceName:(NSString *)serviceName updateExisting:(BOOL)updateExisting error:(NSError **)error;

/**
 *	@brief	删除某个用户信息
 *
 *	@param 	username 	用户名
 *	@param 	serviceName 	App identifier
 *	@param 	error 	error
 *
 *	@return	是否删除成功
 */
+ (BOOL)deleteItemForUsername:(NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error;


///**
// *	@brief	查询所有的KeyChain 信息
// */
//+ (void) selectAllKeyChainInfo;

@end