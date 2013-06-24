//
//  ViewController.m
//  BmiSample
//
//  Created by kazuyoshi kawakami on 13/06/22.
//  Copyright (c) 2013年 kazuyoshi kawakami. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField * weightText;
@property (weak, nonatomic) IBOutlet UITextField * heightText;
@property (weak, nonatomic) IBOutlet UILabel     * resultLabel;
@property (strong, nonatomic) AVAudioPlayer      * audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)sound:(NSString *)file
{
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:file ofType:@"m4a"]];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer play];
}

- (IBAction)bmiButtonPushed:(id)sender
{
    float h = _heightText.text.floatValue / 100;
    float w = _weightText.text.floatValue;
    
    float bmi = w / ( h * h );
    NSLog(@"bmi = %f", bmi);
    
    if ( bmi >= 25 ) {
        _resultLabel.text = @"太り過ぎ";
        _resultLabel.backgroundColor = [UIColor redColor];
        [self sound:@"fat"];
    } else if ( bmi < 18.5 ) {
        _resultLabel.text = @"やせすぎ";
        _resultLabel.backgroundColor = [UIColor yellowColor];
        [self sound:@"skinny"];
    } else {
        _resultLabel.text = @"標準";
        _resultLabel.backgroundColor = [UIColor greenColor];
        [self sound:@"normal"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
