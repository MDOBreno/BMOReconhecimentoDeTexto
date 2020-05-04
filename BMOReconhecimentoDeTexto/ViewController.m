//
//  ViewController.m
//  BMOReconhecimentoDeTexto
//
//  Created by Breno Medeiros on 23/04/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import "ViewController.h"
#import "Cronometro.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Languages are used for recognition (e.g. eng, ita, etc.). Tesseract engine
    // will search for the .traineddata language file in the tessdata directory.
    // For example, specifying "eng+ita" will search for "eng.traineddata" and
    // "ita.traineddata". Cube engine will search for "eng.cube.*" files.
    // See https://github.com/tesseract-ocr/tessdata.

    // Create your G8Tesseract object using the initWithLanguage method:
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"por+spa+eng"];

    // Optionaly: You could specify engine to recognize with.
    // G8OCREngineModeTesseractOnly by default. It provides more features and faster
    // than Cube engine. See G8Constants.h for more information.
    //tesseract.engineMode = G8OCREngineModeTesseractOnly;

    // Set up the delegate to receive Tesseract's callbacks.
    // self should respond to TesseractDelegate and implement a
    // "- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract"
    // method to receive a callback to decide whether or not to interrupt
    // Tesseract before it finishes a recognition.
    tesseract.delegate = self;

    // Optional: Limit the character set Tesseract should try to recognize from
    //tesseract.charWhitelist = @"0123456789";

    // This is wrapper for common Tesseract variable kG8ParamTesseditCharWhitelist:
    // [tesseract setVariableValue:@"0123456789" forKey:kG8ParamTesseditCharBlacklist];
    // See G8TesseractParameters.h for a complete list of Tesseract variables

    // Optional: Limit the character set Tesseract should not try to recognize from
    //tesseract.charBlacklist = @"OoZzBbSs";

    // Specify the image Tesseract should recognize on
    tesseract.image = [[UIImage imageNamed:@"Teste.png"] g8_blackAndWhite];

    // Optional: Limit the area of the image Tesseract should recognize on to a rectangle
    //tesseract.rect = CGRectMake(20, 20, 100, 100);

    // Optional: Limit recognition time with a few seconds
    //tesseract.maximumRecognitionTime = 2.0;
    
    // Começa um cronometro
    Cronometro *cronometro = [[Cronometro alloc] init];
    [cronometro startTimer];
    
    // Start the recognition
    [tesseract recognize];
    
    // Encerra o cronometro
    [cronometro stopTimer];
    tempoMilisegundos = [[NSNumber numberWithDouble:[cronometro timeElapsedInMilliseconds]] stringValue];
    tempoMilisegundos = [NSString stringWithFormat:@"%@ ms", tempoMilisegundos];
    


    // Retrieve the recognized text
    NSLog(@"%@", [tesseract recognizedText]);
    
    _tvTexto.text = [tesseract recognizedText];

    // You could retrieve more information about recognized text with that methods:
    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
    NSArray *characterChoices = tesseract.characterChoices;
    _ivTeste.image = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
}

- (void) viewDidAppear:(BOOL)animated {
    // Exite o tempo de OCR
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Google OCR Concluido"
                               message:tempoMilisegundos
                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Visualizar" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
}



@end
