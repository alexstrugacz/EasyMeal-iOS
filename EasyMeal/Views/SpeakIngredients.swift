//
//  SpeakIngredients.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import SwiftUI

struct SpeakIngredients: View {
    
    var closeSpeakIngredients: () -> Void
    @ObservedObject var speakIngredientsViewModel: SpeakIngredientsViewModel 
    @StateObject var speechRecognizer: SpeechRecognizer = SpeechRecognizer()
   
    func startRecording() {
        speakIngredientsViewModel.startRecording()
        if (!speakIngredientsViewModel.recorded) {
            speechRecognizer.resetTranscript()
        }
        speechRecognizer.startTranscribing()
        
    }
    
    func stopRecording() {
        let seconds = 2.0
        speakIngredientsViewModel.stopRecording()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            speechRecognizer.stopTranscribing()
            
            speakIngredientsViewModel.text += speechRecognizer.transcript + " "
        }
    }
    
    
    func reset() {
        speakIngredientsViewModel.text = ""
        speakIngredientsViewModel.resetRecording()
        speechRecognizer.resetTranscript()
        
    }
    
    init(newCloseSpeakIngredients: @escaping () -> Void) {
        closeSpeakIngredients = newCloseSpeakIngredients
        speakIngredientsViewModel = SpeakIngredientsViewModel(exit: newCloseSpeakIngredients)
    }
    
    
    var body: some View {
        if ( speakIngredientsViewModel.resultsDisplayed) {
            VStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        closeSpeakIngredients()
                    }) {
                        HStack(spacing: 3) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14))
                            Text("Exit")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                        }
                        .foregroundColor(.blue)
                    }
                    Text("Speak Ingredients")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 5)
                    if (speakIngredientsViewModel.results.count > 0) {
                        Text("The following will be added:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
                            .padding(.horizontal, 5)
                    }
                    ScrollView(showsIndicators: false) {
                        VStack {
                            if (speakIngredientsViewModel.results.count == 0) {
                                Text("No ingredients found. You may have mentioned ingredients that weren't in our database.")
                            } else {
                                Text("Note: Only ingredients in our database are logged").font(.system(size: 12))
                                
                            }
                            ForEach(speakIngredientsViewModel.results, id: \.self) { result in
                                Text(result)
                                    .fontWeight(.bold)
                                    .padding(5)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                        
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 5)
                                            .shadow(color: Color(hex: "#d4d4d4"), radius: 5,x: 0, y: 5)
                                    )
                            }
                        }
                    }
                    HStack {
                        
                        Button {
                            speakIngredientsViewModel.exitSubmission()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.uturn.forward")
                                    .font(.system(size: 18))
                                Text("Go Back")
                                    .fontWeight(.bold
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(LinearGradient(gradient: Gradient(colors: [.gray, .gray]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                        }
                        
                        if (speakIngredientsViewModel.results.count > 0) {
                            Button {
                                speakIngredientsViewModel.addResults()
                            } label: {
                                HStack {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 18))
                                    Text("Submit")
                                        .fontWeight(.bold
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                            }
                        }
                        
                    }
                    Spacer()
                }
                .padding(20)
            }
            .background(Color(hex: "#F7F7F7"))
            
        } else {
            VStack(alignment: .leading) {
                
                Button(action: {
                    closeSpeakIngredients()
                }) {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14))
                        Text("Exit")
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
                Text("Speak Ingredients")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 5)
                    .padding(.bottom, 2)
                if !speakIngredientsViewModel.recording {
                    Text("Press the play button to begin speaking your ingredients.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
                        .padding(.horizontal, 5)
                } else {
                    Text("Say what's in your pantry.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
                        .padding(.horizontal, 5)
                }
                
                Spacer()
                if (speakIngredientsViewModel.recording) {
                    Text(speakIngredientsViewModel.text + speechRecognizer.transcript)
                        .animation(.easeInOut)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
                        .padding(.horizontal, 5)
                } else if (speakIngredientsViewModel.recorded) {
                    Text(speakIngredientsViewModel.text)
                        .animation(.easeInOut)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
                        .padding(.horizontal, 5)
                    
                }
                
                if speakIngredientsViewModel.recording {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "circle.fill")
                            .font(.system(size:14))
                            .foregroundColor(.red)
                        Text("Recording")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        PlayButton(playing: $speakIngredientsViewModel.recording, startRecording: startRecording, stopRecording: stopRecording)
                        Spacer()
                        
                    }
                    .padding(.bottom, 30)
                    .padding(.top, 20)
                
                }
                if( speakIngredientsViewModel.recorded && !speakIngredientsViewModel.recording && (speakIngredientsViewModel.text.trimmingCharacters(in: .whitespacesAndNewlines).count>0)) {
                    Spacer()
                    Button {
                        speakIngredientsViewModel.submitRecording()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .font(.system(size: 18))
                            Text("Submit Recording")
                                .fontWeight(.bold
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                    }
                    
                    Button {
                        reset()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 18))
                            Text("Restart Recording")
                                .fontWeight(.bold
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(LinearGradient(gradient: Gradient(colors: [.gray, .gray]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                    }
                    
                } else {
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(20)
            .background(Color(hex: "#F7F7F7"))
            .fullScreenCover(isPresented: $speakIngredientsViewModel.loading, content: {
                ZStack{
                    Color.black.opacity(0.01).edgesIgnoringSafeArea(.all)
                    VStack {
                        ProgressView()
                    }
                }
                .background(BackgroundBlurView())
            })
        }
            
    }
}
