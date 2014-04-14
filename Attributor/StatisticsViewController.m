//
//  StatisticsViewController.m
//  Attributor
//
//  Created by Dave Carpenter on 4/14/14.
//  Copyright (c) 2014 Dave Carpenter. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *coloredCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation StatisticsViewController

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) updateUI
{
    self.coloredCharactersLabel.text = [NSString stringWithFormat:@"%lu colored characters", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu colored characters", (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *) charactersWithAttribute:(NSString *) attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze.string length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int) (range.location + range.length);
        } else {
            index++;
        }
    }
    
    return characters;
}


@end
