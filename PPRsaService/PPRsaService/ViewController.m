//
//  ViewController.m
//  RSAtest
//
//  Created by 熊吉 on 2017/3/2.
//  Copyright © 2017年 人民车位. All rights reserved.
//

#import "ViewController.h"
#import "PPRsaService.h"

@interface ViewController ()
@property (nonatomic, strong) PPRsaService *manager;

@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UIButton *enBtn;
@property (weak, nonatomic) IBOutlet UIButton *deBtn;
@property (weak, nonatomic) IBOutlet UIButton *sigBtn;
@property (weak, nonatomic) IBOutlet UILabel *result1;

@property (weak, nonatomic) IBOutlet UILabel *result2;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* private_key_string = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANNZIb1A6pJo/16PzKVl5Q1hBz14yQYVEl0gaIP05V+fDjPHYMGfRqr3u5F5g2kdHhxuwFnY5rq3SA97ToMRmSsIEn2bDZHXcSB6+Cs3AQC63VWjoREjHPyuLrwPvNShk3zARQYr32zvo+7vEkTA9p9JHFtpWLuAdY43vtqSCDmpAgMBAAECgYEAnG6Qpn/yH8RPoDJXiuTMkQaMUVehkzrtiLiAI4uUax5TaMfeOfImYE1VK+wA9EB1FR50iQweW31lfPALwL+52eOcsMcaibOw+xzJbKrCVXCXWxWBBJdvFeNlAQ4SspWGjCdbZKkKriSmBfuIhOXlEBwLPtjaiuc0UYajBdMkigECQQDpq1LXW4dnIYbGiroke5wJl99FEpD+twWqFVzwFWd3Z1vokPllqgcDcWZ07kcjgGijJyi44sF3KkjjJF6OdbWRAkEA54u6NRoAvMyT07A/NbIKLcYAnRrUB9aZt9sdtXjwXJkWvfOcnW190pcWPj0RJm8GiG2tnKGcuKMa9+gqn7BWmQJBAJaDGntJo7AUcmHU3g296UZsow405VyMu4NQ+2pR/zF0TElDiMGpgZcAJoTPLtd5UO02vg5JUWDWxdg5hwawX2ECQDcTqI5bChPewccX5GE8YWlz8M9uA0N+C4CNUWrKQrpz+9HhMb7MvaIrKDJTylGPFUm8dRCN7L6Kpa6UfhcQFfkCQEe5+VLDdteRGpKZnE+A+HdemMzD9YRDgSQRtqhCOUTFF9juZkehrn7TCJ9gahXttyyG4mImYKa4kBqZIhYbKwc=";
    
    
    NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTWSG9QOqSaP9ej8ylZeUNYQc9eMkGFRJdIGiD9OVfnw4zx2DBn0aq97uReYNpHR4cbsBZ2Oa6t0gPe06DEZkrCBJ9mw2R13EgevgrNwEAut1Vo6ERIxz8ri68D7zUoZN8wEUGK99s76Pu7xJEwPafSRxbaVi7gHWON77akgg5qQIDAQAB";
    
    
    
    
    PPRsaService* manager = [PPRsaService new];
    
    [manager importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
    [manager importKeyWithType:KeyTypePublic andkeyString:public_key_string];
    _manager = manager;
}



/**
 加密
 */
- (IBAction)enClick:(id)sender {
    if(self.input.text.length > 0 ){
        NSString* result = [_manager encryptWithPublicKey:self.input.text];
        self.result1.text = result;
    }
}
/**
 签名
 */
- (IBAction)signClick:(id)sender {
    if(self.input.text.length > 0 ){
        NSString* result = [_manager signString:self.input.text];
        self.result1.text = result;
    }
}
/**
 解密
 */
- (IBAction)deClick:(id)sender {
    if(self.result1.text.length > 0 ){
        NSString* result = [_manager decryptWithPrivatecKey:self.result1.text];
        self.result2.text = result;
    }
}
/**
 验证签名
 */
- (IBAction)verifyClick:(id)sender {
    if(self.result1.text.length > 0  && self.input.text.length > 0){
        BOOL result = [_manager verifyString:self.input.text withSign:self.result1.text];
        self.result2.text = [NSString stringWithFormat:@"验证签名结果(1成功，0失败)： %d",result];
    }
}

@end
