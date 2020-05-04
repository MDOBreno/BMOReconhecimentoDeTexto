//
//  Cronometro.h
//  BMOReconhecimentoDeTexto
//
//  Created by Breno Medeiros on 04/05/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cronometro : NSObject {
    NSDate *start;
    NSDate *end;
}

- (void) startTimer;
- (void) stopTimer;
- (double) timeElapsedInSeconds;
- (double) timeElapsedInMilliseconds;
- (double) timeElapsedInMinutes;

@end
