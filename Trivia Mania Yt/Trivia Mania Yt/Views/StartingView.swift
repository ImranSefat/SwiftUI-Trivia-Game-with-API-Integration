//
//  StartingView.swift
//  Trivia Mania Yt
//
//  Created by Imran Sefat on 11/4/22.
//

import SwiftUI

struct StartingView: View {
    var body: some View {
        NavigationView{
            content
                .navigationTitle("Home")
        }
        
        
        
    }
    
    var content : some View {
        VStack(spacing: 20) {
            Spacer()
            Image("illustrations-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 320, height: 220)
                .padding(.vertical, 20)
            
            Text("Trivia Mania".uppercased())
                .font(.largeTitle.weight(.bold))
            
            Spacer()
            
            
            NavigationLink {
                QuestionView()
            } label: {
                HStack{
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.green)
                    
                    Text("Start".uppercased())
                        .font(.title2.weight(.semibold))
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
            }
            .buttonStyle(.plain)
            
            Spacer()
                
            
        }
        
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
            .preferredColorScheme(.dark)
    }
}
