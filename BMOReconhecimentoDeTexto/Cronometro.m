//
//  Cronometro.m
//  BMOReconhecimentoDeTexto
//
//  Created by Breno Medeiros on 04/05/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import "Cronometro.h"

@implementation Cronometro

- (id) init {
    self = [super init];
    if (self != nil) {
        start = nil;
        end = nil;
    }
    return self;
}

- (void) startTimer {
    start = [NSDate date];
}

- (void) stopTimer {
    end = [NSDate date];
}

- (double) timeElapsedInSeconds {
    return [end timeIntervalSinceDate:start];
}

- (double) timeElapsedInMilliseconds {
    return [self timeElapsedInSeconds] * 1000.0f;
}

- (double) timeElapsedInMinutes {
    return [self timeElapsedInSeconds] / 60.0f;
}

@end
