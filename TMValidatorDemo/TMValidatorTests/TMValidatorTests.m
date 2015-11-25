//
//  TMValidatorTests.m
//  TMValidatorTests
//
//  Created by Kazuya Ueoka on 2015/11/18.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TMValidator.h"

@interface TMValidatorTests : XCTestCase

@end

@implementation TMValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRequired {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertFalse([TMValidatorRuleRequired run:nil], @"required is nil");
    XCTAssertFalse([TMValidatorRuleRequired run:@""], @"required is empty");
    XCTAssertTrue([TMValidatorRuleRequired run:@"a"], @"required is a");
    XCTAssertTrue([TMValidatorRuleRequired run:@"123"], @"required is 123");
}

- (void)testExactLength
{
    XCTAssertTrue([TMValidatorRuleExactLength run:nil withLength:@10], @"exactLength is nil");
    XCTAssertFalse([TMValidatorRuleExactLength run:@"1" withLength:@10], @"exactLength is 1");
    XCTAssertFalse([TMValidatorRuleExactLength run:@"123456789" withLength:@10], @"exactLength is 123456789");
    XCTAssertTrue([TMValidatorRuleExactLength run:@"0123456789" withLength:@10], @"exactLength is 0123456789");
    XCTAssertFalse([TMValidatorRuleExactLength run:@"0123456789a" withLength:@10], @"exactLength is 01234567890a");
}

- (void)testMinLength
{
    XCTAssertTrue([TMValidatorRuleMinLength run:nil withLength:@10], @"minLength is nil");
    XCTAssertFalse([TMValidatorRuleMinLength run:@"1" withLength:@10], @"minLength is 1");
    XCTAssertFalse([TMValidatorRuleMinLength run:@"123456789" withLength:@10], @"minLength is 123456789");
    XCTAssertTrue([TMValidatorRuleMinLength run:@"0123456789" withLength:@10], @"minLength is 0123456789");
    XCTAssertTrue([TMValidatorRuleMinLength run:@"0123456789a" withLength:@10], @"minLength is 0123456789a");
}

- (void)testMaxLength
{
    XCTAssertTrue([TMValidatorRuleMaxLength run:nil withLength:@10], @"maxLength is nil");
    XCTAssertTrue([TMValidatorRuleMaxLength run:@"1" withLength:@10], @"maxLength is 1");
    XCTAssertTrue([TMValidatorRuleMaxLength run:@"123456789" withLength:@10], @"maxLength is 123456789");
    XCTAssertTrue([TMValidatorRuleMaxLength run:@"0123456789" withLength:@10], @"maxLength is 0123456789");
    XCTAssertFalse([TMValidatorRuleMaxLength run:@"0123456789a" withLength:@10], @"maxLength is 0123456789a");
}

- (void)testIsNumeric
{
    XCTAssertTrue([TMValidatorRuleIsNumeric run:nil], @"isNumeric is nil");
    XCTAssertFalse([TMValidatorRuleIsNumeric run:@"a"], @"isNumeric is a");
    XCTAssertTrue([TMValidatorRuleIsNumeric run:@"-123"], @"isNumeric is -123");
    XCTAssertTrue([TMValidatorRuleIsNumeric run:@"+123"], @"isNumeric is +123");
    XCTAssertTrue([TMValidatorRuleIsNumeric run:@"123.0123456789"], @"isNumeric is 123.0123456789");
    XCTAssertFalse([TMValidatorRuleIsNumeric run:@"+-123"], @"isNumeric is +-123");
    XCTAssertTrue([TMValidatorRuleIsNumeric run:@"123456789"], @"isNumeric is 123456789");
}

- (void)testIsAlphabet
{
    XCTAssertTrue([TMValidatorRuleIsAlphabet run:nil], @"isAlphabet is nil");
    XCTAssertTrue([TMValidatorRuleIsAlphabet run:@"abcDEF"], @"isAlphabet is abcDEF");
    XCTAssertFalse([TMValidatorRuleIsAlphabet run:@"abcDEF123"], @"isAlphabet is abcDEF123");
    XCTAssertTrue([TMValidatorRuleIsAlphabet run:@"abcdefghijklmnopqrstuvxxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"], @"isAlphabet is abcdefghijklmnopqrstuvxxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
    XCTAssertFalse([TMValidatorRuleIsAlphabet run:@"日本語"], @"isAlphabet is 日本語");
}

- (void)testIsAlnum
{
    XCTAssertTrue([TMValidatorRuleIsAlnum run:nil], @"isAlnum is nil");
    XCTAssertTrue([TMValidatorRuleIsAlnum run:@"abcDEF"], @"isAlnum is abcDEF");
    XCTAssertTrue([TMValidatorRuleIsAlnum run:@"abcDEF123"], @"isAlnum is abcDEF123");
    XCTAssertTrue([TMValidatorRuleIsAlnum run:@"abcdefghijklmnopqrstuvxxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"], @"isAlnum is abcdefghijklmnopqrstuvxxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
    XCTAssertFalse([TMValidatorRuleIsAlnum run:@"日本語"], @"isAlnum is 日本語");
}

- (void)testMatchValue
{
    XCTAssertTrue([TMValidatorRuleMatchValue run:nil withValue:@"test"], @"matchValue is nil");
    XCTAssertFalse([TMValidatorRuleMatchValue run:@"123" withValue:@"test"], @"matchValue is 123");
    XCTAssertTrue([TMValidatorRuleMatchValue run:@"test" withValue:@"test"], @"matchValue is test");
    XCTAssertFalse([TMValidatorRuleMatchValue run:@"TEST" withValue:@"test"], @"matchValue is TEST");
    XCTAssertFalse([TMValidatorRuleMatchValue run:@"test123" withValue:@"test"], @"matchValue is test123");
}

- (void)testNumericMin
{
    XCTAssertTrue([TMValidatorRuleNumericMin run:nil withNumeric:@123], @"numericMin is nil");
    XCTAssertFalse([TMValidatorRuleNumericMin run:@"abc" withNumeric:@123], @"numericMin is abc");
    XCTAssertTrue([TMValidatorRuleNumericMin run:@"124" withNumeric:@123], @"numericMin is 124");
    XCTAssertTrue([TMValidatorRuleNumericMin run:@"123" withNumeric:@123], @"numericMin is 123");
    XCTAssertFalse([TMValidatorRuleNumericMin run:@"122" withNumeric:@123], @"numericMin is 122");
}

- (void)testNumericMax
{
    XCTAssertTrue([TMValidatorRuleNumericMax run:nil withNumeric:@123], @"numericMax is nil");
    XCTAssertFalse([TMValidatorRuleNumericMax run:@"abc" withNumeric:@123], @"numericMax is abc");
    XCTAssertFalse([TMValidatorRuleNumericMax run:@"124" withNumeric:@123], @"numericMax is 124");
    XCTAssertTrue([TMValidatorRuleNumericMax run:@"123" withNumeric:@123], @"numericMax is 123");
    XCTAssertTrue([TMValidatorRuleNumericMax run:@"122" withNumeric:@123], @"numericMax is 122");
}

- (void)testNumericBetween
{
    XCTAssertTrue([TMValidatorRuleNumericBetween run:nil withNumericMin:@123 andNumericMax:@456], @"numericBetween is nil");
    XCTAssertTrue([TMValidatorRuleNumericBetween run:@"200" withNumericMin:@123 andNumericMax:@456], @"numericBetween is 200");
    XCTAssertFalse([TMValidatorRuleNumericBetween run:@"122" withNumericMin:@123 andNumericMax:@456], @"numericBetween is 122");
    XCTAssertTrue([TMValidatorRuleNumericBetween run:@"123" withNumericMin:@123 andNumericMax:@456], @"numericBetween is 123");
    XCTAssertTrue([TMValidatorRuleNumericBetween run:@"456" withNumericMin:@123 andNumericMax:@456], @"numericBetween is 456");
    XCTAssertFalse([TMValidatorRuleNumericBetween run:@"457" withNumericMin:@123 andNumericMax:@456], @"numericBetween is 457");
    XCTAssertFalse([TMValidatorRuleNumericBetween run:@"abc" withNumericMin:@123 andNumericMax:@456], @"numericBetween is abc");
}

- (void)testEmail
{
    XCTAssertTrue([TMValidatorRuleEmail run:nil], @"email is nil");
    XCTAssertTrue([TMValidatorRuleEmail run:@""], @"email is empty");
    XCTAssertTrue([TMValidatorRuleEmail run:@"Abc@example.com"], @"email is Abc@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"Abc.123@example.com"], @"email is Abc.123@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"user+mailbox/department=shipping@example.com"], @"email is user+mailbox/department=shipping@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"!#$%&'*+-/=?^_`.{|}~@example.com"], @"email is !#$\'*+-/=?^_`.{|}~@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"\"Abc@def\"@example.com"], @"email is \"Abc@def\"@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"\"Fred\\ Bloggs\"@example.com"], @"email is \"Fred\\ Bloggs\"@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"\"Joe.\\Blow\"@example.com"], @"email is \"Joe.\\Blow\"@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"\".dot_kara_hazimaru\"@example.com"], @"email is \".dot_kara_hazimaru\"@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"\"I.likeyou.\"@example.com"], @"email is \"I.likeyou.\"@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"\"I..love...you\"@example.com"], @"email is \"I..love...you\"@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"Abc.@example.com"], @"email is Abc.@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"Abc..123@example.com"], @"email is Abc..123@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@".dot_kara_hazimaru@example.com"], @"email is .dot_kara_hazimaru@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"I.like.you.@example.com"], @"email is I.like.you.@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"I..love...you@example.com"], @"email is I..love...you@example.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@[0.0.0.0]"], @"email is a@[0.0.0.0]");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@[255.255.255.255]"], @"email is a@[255.255.255.255]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[255.255.255.256]"], @"email is a@[255.255.255.256]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[001.002.003.004]"], @"email is a@[001.002.003.004]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:0db8:bd05:01d2:288a:1fc0:0001:10ee]"], @"email is a@[2001:0db8:bd05:01d2:288a:1fc0:0001:10ee]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:0db8:bd05:01d2:288a::1fc0:0001:10ee]"], @"email is a@[2001:0db8:bd05:01d2:288a::1fc0:0001:10ee]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:0db8:bd05:01d2:288a:1fc0:0001:10ee:11fe]"], @"email is a@[2001:0db8:bd05:01d2:288a:1fc0:0001:10ee:11fe]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:db8:20:3:1000:100:20:3]"], @"email is a@[2001:db8:20:3:1000:100:20:3]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:db8::1234:0:0:9abc]"], @"email is a@[2001:db8::1234:0:0:9abc]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:db8::9abc]"], @"email is a@[2001:db8::9abc]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[::]"], @"email is a@[::]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[0::0]"], @"email is a@[0::0]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[::1]"], @"email is a@[::1]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[1::]"], @"email is a@[1::]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[1:2:3:4:5:6:7::]"], @"email is a@[1:2:3:4:5:6:7::]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[::255.255.255.255]"], @"email is a@[::255.255.255.255]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[::ffff:255.255.255.255]"], @"email is a@[::ffff:255.255.255.255]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[::ffff:0:255.255.255.255]"], @"email is a@[::ffff:0:255.255.255.255]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[2001:db8:3:4::192.0.2.33]"], @"email is a@[2001:db8:3:4::192.0.2.33]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[64:ff9b::192.0.2.33]"], @"email is a@[64:ff9b::192.0.2.33]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[example.com]"], @"email is a@[example.com]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@[example.com:hoge]"], @"email is a@[example.com:hoge]");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@0"], @"email is a@0");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@a"], @"email is a@a");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@0.a"], @"email is a@0.a");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@0.0"], @"email is a@0.0");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@a.0"], @"email is a@a.0");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@.a"], @"email is a@.a");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@a-.a"], @"email is a@a-.a");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@-a.a"], @"email is a@-a.a");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@a-a.com"], @"email is a@a-a.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@0-a.com"], @"email is a@0-a.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@a-0.com"], @"email is a@a-0.com");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@a-a.a-a"], @"email is a@a-a.a-a");
    XCTAssertTrue([TMValidatorRuleEmail run:@"a@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890.com"], @"email is a@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"a@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ012345678901.com"], @"email is a@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ012345678901.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/@example.com"], @"email is abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/a@example.com"], @"email is abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/a@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"\"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/\"@example.com"], @"email is \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/\"@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"\"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/a\"@example.com"], @"email is \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/a\"@example.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"abcdefhghijklmnopqrstuvwxyzABC@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com"], @"email is abcdefhghijklmnopqrstuvwxyzABC@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"abcdefhghijklmnopqrstuvwxyzABCD@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com"], @"email is abcdefhghijklmnopqrstuvwxyzABCD@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"\"abcdefhghijklmnopqrstuvwxyzABC\"@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com"], @"email is \"abcdefhghijklmnopqrstuvwxyzABC\"@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com");
    //XCTAssertTrue([TMValidatorRuleEmail run:@"\"abcdefhghijklmnopqrstuvwxyzABCD\"@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com"], @"email is \"abcdefhghijklmnopqrstuvwxyzABCD\"@aaaaaaaa01.aaaaaaaa02.aaaaaaaa03.aaaaaaaa04.aaaaaaaa05.aaaaaaaa06.aaaaaaaa07.aaaaaaaa08.aaaaaaaa09.aaaaaaaa10.aaaaaaaa11.aaaaaaaa12.aaaaaaaa13.aaaaaaaa14.aaaaaaaa15.aaaaaaaa16.aaaaaaaa17.aaaaaaaa18.aaaaaaaa19.aaaaaaaa20.com");
}

- (void)testURL
{
    XCTAssertTrue([TMValidatorRuleURL run:nil], @"url is nil");
    XCTAssertTrue([TMValidatorRuleURL run:@""], @"url is empty");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/blah_blah"], @"url is http://foo.com/blah_blah");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/blah_blah/"], @"url is http://foo.com/blah_blah/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/blah_blah_(wikipedia)"], @"url is http://foo.com/blah_blah_(wikipedia)");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/blah_blah_(wikipedia)_(again)"], @"url is http://foo.com/blah_blah_(wikipedia)_(again)");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://www.example.com/wpstyle/?p=364"], @"url is http://www.example.com/wpstyle/?p=364");
    XCTAssertTrue([TMValidatorRuleURL run:@"https://www.example.com/foo/?bar=baz&inga=42&quux"], @"url is https://www.example.com/foo/?bar=baz&inga=42&quux");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://✪df.ws/123"], @"url is http://✪df.ws/123");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid:password@example.com:8080"], @"url is http://userid:password@example.com:8080");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid:password@example.com:8080/"], @"url is http://userid:password@example.com:8080/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid@example.com"], @"url is http://userid@example.com");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid@example.com/"], @"url is http://userid@example.com/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid@example.com:8080"], @"url is http://userid@example.com:8080");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid@example.com:8080/"], @"url is http://userid@example.com:8080/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid:password@example.com"], @"url is http://userid:password@example.com");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://userid:password@example.com/"], @"url is http://userid:password@example.com/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://142.42.1.1/"], @"url is http://142.42.1.1/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://142.42.1.1:8080/"], @"url is http://142.42.1.1:8080/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://➡.ws/䨹"], @"url is http://➡.ws/䨹");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://⌘.ws"], @"url is http://⌘.ws");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://⌘.ws/"], @"url is http://⌘.ws/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/blah_(wikipedia)#cite-1"], @"url is http://foo.com/blah_(wikipedia)#cite-1");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/blah_(wikipedia)_blah#cite-1"], @"url is http://foo.com/blah_(wikipedia)_blah#cite-1");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/unicode_(✪)_in_parens"], @"url is http://foo.com/unicode_(✪)_in_parens");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.com/(something)?after=parens"], @"url is http://foo.com/(something)?after=parens");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://☺.damowmow.com/"], @"url is http://☺.damowmow.com/");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://code.google.com/events/#&product=browser"], @"url is http://code.google.com/events/#&product=browser");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://j.mp"], @"url is http://j.mp");
    XCTAssertTrue([TMValidatorRuleURL run:@"ftp://foo.bar/baz"], @"url is ftp://foo.bar/baz");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://foo.bar/?q=Test%20URL-encoded%20stuff"], @"url is http://foo.bar/?q=Test&URL-encoded&stuff");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://例子.测试"], @"url is http://例子.测试");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://उदाहरण.परीक्षा"], @"url is http://उदाहरण.परीक्षा");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://-.~_!$&'()*+,;=:%40:80%2f::::::@example.com"], @"url is http://-.~_!$&'()*+,;=::80::::::@example.com");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://1337.net"], @"url is http://1337.net");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://a.b-c.de"], @"url is http://a.b-c.de");
    XCTAssertTrue([TMValidatorRuleURL run:@"http://223.255.255.254"], @"url is http://223.255.255.254");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://"], @"url is http://");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://."], @"url is http://.");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://.."], @"url is http://..");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://../"], @"url is http://../");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://?"], @"url is http://?");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://??"], @"url is http://??");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://??/"], @"url is http://??/");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://#"], @"url is http://#");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://##"], @"url is http://##");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://##/"], @"url is http://##/");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://foo.bar?q=Spaces"], @"url is http://foo.bar?q=Spaces");
    XCTAssertFalse([TMValidatorRuleURL run:@"//"], @"url is //");
    XCTAssertFalse([TMValidatorRuleURL run:@"//a"], @"url is //a");
    XCTAssertFalse([TMValidatorRuleURL run:@"///a"], @"url is ///a");
    XCTAssertFalse([TMValidatorRuleURL run:@"///"], @"url is ///");
    XCTAssertFalse([TMValidatorRuleURL run:@"http:///a"], @"url is http:///a");
    XCTAssertFalse([TMValidatorRuleURL run:@"foo.com"], @"url is foo.com");
    XCTAssertFalse([TMValidatorRuleURL run:@"rdar://1234"], @"url is rdar://1234");
    XCTAssertFalse([TMValidatorRuleURL run:@"h://test"], @"url is h://test");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://"], @"url is http://");
    XCTAssertFalse([TMValidatorRuleURL run:@"://"], @"url is ://");
    //XCTAssertFalse([TMValidatorRuleURL run:@"http://foo.bar/foo(bar)baz"], @"url is http://foo.bar/foo(bar)baz");
    XCTAssertFalse([TMValidatorRuleURL run:@"ftps://foo.bar/"], @"url is ftps://foo.bar/");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://-error-.invalid/"], @"url is http://-error-.invalid/");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://a.b--c.de/"], @"url is http://a.b--c.de/");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://-a.b.co"], @"url is http://-a.b.co");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://a.b-.co"], @"url is http://a.b-.co");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://0.0.0.0"], @"url is http://0.0.0.0");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://10.1.1.0"], @"url is http://10.1.1.0");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://10.1.1.255"], @"url is http://10.1.1.255");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://224.1.1.1"], @"url is http://224.1.1.1");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://1.1.1.1.1"], @"url is http://1.1.1.1.1");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://123.123.123"], @"url is http://123.123.123");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://3628126748"], @"url is http://3628126748");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://.www.foo.bar/"], @"url is http://.www.foo.bar/");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://www.foo.bar./"], @"url is http://www.foo.bar./");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://.www.foo.bar./"], @"url is http://.www.foo.bar./");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://10.1.1.1"], @"url is http://10.1.1.1");
    XCTAssertFalse([TMValidatorRuleURL run:@"http://10.1.1.254"], @"url is http://10.1.1.254");
}

- (void)testMatchPatter
{
    NSString *pattern = @"^([0-9]{4})[/\\.\\-]{1}([0-9]{1,2})[/\\.\\-]{1}([0-9]{1,2})$";
    
    XCTAssert([TMValidatorRuleMatchPattern run:@"2015/11/30" withPattern:pattern matches:^(NSArray *matches) {
        NSLog(@"%@", matches);
    }]);
    XCTAssert([TMValidatorRuleMatchPattern run:@"2015.11.30" withPattern:pattern matches:^(NSArray *matches) {
        NSLog(@"%@", matches);
    }]);
    XCTAssert([TMValidatorRuleMatchPattern run:@"2015-11-30" withPattern:pattern matches:^(NSArray *matches) {
        NSLog(@"%@", matches);
    }]);
    XCTAssertFalse([TMValidatorRuleMatchPattern run:@"2015+11+30" withPattern:pattern matches:^(NSArray *matches) {
        NSLog(@"%@", matches);
    }]);
}

- (void)testValidatorRun
{
    TMValidator *validator = [TMValidator validator];
    
    [validator addField:[TMValidatorField requiredFieldWithValue:@"a" andLabel:@"required" andElement:nil]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"abcdef" andLabel:@"required_exactlength" andElement:nil] addRule:[TMValidatorRuleExactLength ruleWithLength:@6]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"abcdef" andLabel:@"required_minLength" andElement:nil] addRule:[TMValidatorRuleMinLength ruleWithLength:@5]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"abcdefghij" andLabel:@"required_maxLength" andElement:nil] addRule:[TMValidatorRuleMaxLength ruleWithLength:@10]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"1234567890" andLabel:@"required_isNumeric" andElement:nil] addRule:[TMValidatorRuleIsNumeric rule]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" andLabel:@"required_isAlphabet" andElement:nil] addRule:[TMValidatorRuleIsAlphabet rule]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890" andLabel:@"required_isAlnum" andElement:nil] addRule:[TMValidatorRuleIsAlnum rule]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"TEST" andLabel:@"required_matchValue" andElement:nil] addRule:[TMValidatorRuleMatchValue ruleWithValue:@"TEST"]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"info+test@fromkk.info" andLabel:@"required_matchPattern" andElement:nil] addRule:[TMValidatorRuleMatchPattern ruleWithPattern:@"^[a-zA-Z0-9]+[a-zA-Z0-9\\._\\-\\+]*[a-zA-Z0-9]+@[a-zA-Z0-9\\._\\-]+\\.[a-zA-Z0-9]+$"]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"200" andLabel:@"required_numericMin" andElement:nil] addRule:[TMValidatorRuleNumericMin ruleWithNumeric:@(123)]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"100" andLabel:@"required_numericMax" andElement:nil] addRule:[TMValidatorRuleNumericMax ruleWithNumeric:@(123)]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"150" andLabel:@"required_numericBetween" andElement:nil] addRule:[TMValidatorRuleNumericBetween ruleWithNumericMin:@100 andNumericMax:@200]]];
    [validator addField:[[TMValidatorField requiredFieldWithValue:@"-123456.7" andLabel:@"TEST" andElement:nil] addRules:@[[TMValidatorRuleIsNumeric rule], [TMValidatorRuleMaxLength ruleWithLength:@10]]]];
    
    XCTAssertTrue([validator runWithSuccesses:^(NSArray *successes) {
        NSLog(@"success! %@", successes);
    } andFailure:^(NSArray *errors) {
        NSLog(@"failure... %@", errors);
    }], @"run");
}

@end
