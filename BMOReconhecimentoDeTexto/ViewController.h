//
//  ViewController.h
//  BMOReconhecimentoDeTexto
//
//  Created by Breno Medeiros on 23/04/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>

@interface ViewController : UIViewController <G8TesseractDelegate> {
    NSString *tempoMilisegundos;
}

@property (weak, nonatomic) IBOutlet UITextView *tvTexto;
@property (weak, nonatomic) IBOutlet UIImageView *ivTeste;



@end

