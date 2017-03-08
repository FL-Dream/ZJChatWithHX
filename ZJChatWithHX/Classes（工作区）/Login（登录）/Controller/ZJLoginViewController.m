//
//  ZJLoginViewController.m
//  ZJChatWithHX
//
//  Created by ZJ on 2017/3/6.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "ZJLoginViewController.h"
#import "ZJTabBarViewController.h"

@interface ZJLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ZJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)login:(UIButton *)sender
{
    
    if ([_loginButton.currentTitle isEqualToString:@"登录"] )
    {
        if (_userNameField.text != nil && _passWordField.text != nil)
        {
            EMError *error = [[EMClient sharedClient] loginWithUsername:_userNameField.text password:_passWordField.text];
            if (!error) {
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                [ToolsObject showSuccessMessage:@"登录成功"];
                SaveData(@"已登录", @"登录状态");
                [self presentViewController:[[ZJTabBarViewController alloc] init] animated:YES completion:nil];
            }
            else
            {
                [ToolsObject showErrorMessage:error.errorDescription];
            }
            
        }
        else
        {
            [ToolsObject showErrorMessage:@"请输入账户密码！"];
        }
    }
    else
    {
        _userNameField.text = nil;
        _passWordField.text = nil;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)registerUser:(UIButton *)sender
{
    if ([_loginButton.currentTitle isEqualToString:@"返回"] )
    {
        if (_userNameField.text != nil && _passWordField.text != nil)
        {
            EMError *error = [[EMClient sharedClient] registerWithUsername:_userNameField.text password:_passWordField.text];
            if (!error) {
                [ToolsObject showSuccessMessage:@"注册成功"];
                [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
            }
            else
            {
                [ToolsObject showErrorMessage:error.errorDescription];
            }
            
        }
    }
    else
    {
        _userNameField.text = nil;
        _passWordField.text = nil;
        [_loginButton setTitle:@"返回" forState:UIControlStateNormal];
    }
    
}

@end
