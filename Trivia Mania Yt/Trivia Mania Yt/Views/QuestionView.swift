//
//  QuestionView.swift
//  Trivia Mania Yt
//
//  Created by Imran Sefat on 11/4/22.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var randomTrivia: [DataModel] = []
    @State var questionCount = 1
    @State var input: String = ""
    @State var score: Int = 0
    @State var finished = false
    
    
    
    
    var body: some View {
        ZStack{
            if !finished {
                VStack {
                    if randomTrivia.capacity != 0 {
                        // this means that there are some trivia datamodel available
                        Text("Question: \(questionCount)/10") // there will be 10 questions only
                            .font(.title.weight(.bold))
                            .padding(.vertical)
                            .padding(.horizontal, 12)
                        
                        Text("Score: \(score)/10")
                            .font(.title.weight(.bold))
                            .padding(.vertical)
                        
                        VStack {
                            Spacer()
                            Text(randomTrivia[0].answer)
                            Text(randomTrivia[0].question)
                                .font(.title.weight(.semibold))
                                .frame(maxWidth: .infinity)
                            
                            TextField(text: $input) {
                                Text("Type your answer here")
                            }
                            .padding(.vertical)
                            
                            // submit button
                            
                            Button {
                                withAnimation{
                                    if(input.lowercased() == randomTrivia[0].answer.lowercased()) {
                                        score = score + 1
                                    }
                                    
                                    // refresh the question or basically get new question
                                    refreshTrivia()
                                    // set the input to empty string ""
                                    input = ""
                                }
                                
                            } label: {
                                HStack{
                                    Image(systemName: "checkmark")
                                        .font(.title2.weight(.semibold))
                                    Text("Submit")
                                        .font(.title2.weight(.semibold))
                                }
                                .foregroundStyle(.green)
                                .padding()
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 30, style: .continuous
                                    )
                                    .fill(.ultraThinMaterial)
                                )
                                
                                
                            }
                            .buttonStyle(.plain)
                            .padding(.vertical, 20)
                            
                            Spacer()

                            HStack {
                                Button {
                                    withAnimation {
                                        refreshTrivia()
                                        score = 0
                                        questionCount = 0
                                    }
                                }label: {
                                    VStack {
                                        Image(systemName: "bolt.slash.fill")
                                            .frame(width: 45, height: 45)
                                            .font(.title.weight(.semibold))
                                            .foregroundStyle(.blue)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                                                    .fill(.ultraThinMaterial)
                                            )
                                        Text("Restart")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                    }
                                    
                                }
                                .buttonStyle(.plain)
                                Spacer()
                                Button {
                                    withAnimation {
                                        refreshTrivia()
                                    }
                                    
                                } label: {
                                    VStack {
                                        Image(systemName: "chevron.forward")
                                            .frame(width: 45, height: 45)
                                            .font(.title.weight(.semibold))
                                            .foregroundStyle(.red)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                                                    .fill(.ultraThinMaterial)
                                            )
                                        Text(questionCount == 10 ? "Finish" : "Next")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                        }
                        
                            
                    }else {
                        ProgressView().progressViewStyle(.circular)
                    }
               }
                .padding(.horizontal, 20)
            }else {
                VStack {
                    modal
                    Button{
                        finished = false
                        questionCount = 0
                        score = 0
                        refreshTrivia()
                    } label: {
                        Text("Try again?")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.ultraThinMaterial)
                            )
                            .padding(.bottom)
                        
                        
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.green)
                    
                    
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Finish")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.ultraThinMaterial)
                            )
                            .padding(.bottom)
                        
                        
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.purple)
                    
                    
                }
//                .frame(height: 500)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .padding(.horizontal, 16)
                )
//                .offset(y: finished ? 0 : 1000)
                
                
            }
        }
        .onAppear{
            withAnimation {
                Api().getData { randomTrivia in
                    self.randomTrivia = randomTrivia
                }
            }
            
        }
        
        
    }
    
    var modal : some View {
        VStack(spacing: 24){
            Image("illustrations-2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 220)
            
            Text("Trivia Completed!")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
                
            
            Text("Score: \(score)")
                .font(.title2)
                .fontWeight(.semibold)
                
        }
        
    }
    
    func refreshTrivia () {
        Api().getData { randomTrivia in
            if questionCount == 10 {
                finished = true
            }else {
                questionCount = questionCount+1
            }
            
            self.randomTrivia = randomTrivia
        }
    }
        
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(
            randomTrivia: [DataModel(answer: "palimony", question: "This word came into vogue in 1979 after Michelle Triola sued Lee Marvin for it")],  input: ""
        )
        .preferredColorScheme(.dark)
    }
}
