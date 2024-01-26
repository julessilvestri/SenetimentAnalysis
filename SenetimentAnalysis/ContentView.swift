//
//  ContentView.swift
//  SenetimentAnalysis
//
//  Created by Jules SILVESTRI on 1/26/24.
//

import SwiftUI

enum Sentimental : String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
    
    func getColor() -> Color {
        switch (self) {
        case .positive :
            return Color(.green)
        case .negative :
            return Color(.red)
        case .mixed :
            return Color(.purple)
        default:
            return Color(.gray)
        }
    }
    
    func getEmoji() -> String {
        switch (self) {
        case .positive :
            return "😃"
        case .negative :
            return "😡"
        case .mixed :
            return "🤨"
        default:
            return "😑"
        }
    }
}

struct ContentView: View {
    @State var modelInput: String = "Entrez votre phrase..."
    @State var outputSentiment: Sentimental?
    
    func classify() {
        do {
            let model = try SentimentAnalysis_1(configuration: .init())
            let prediction = try model.prediction(text: modelInput)
            outputSentiment = Sentimental(rawValue: prediction.label)
            
        } catch {
            outputSentiment = Sentimental(rawValue: "Something went wrong")
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Text("Entrez une phrase, l'IA va deviner votre sentiment")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .padding()
                    
                    TextEditor(text: $modelInput)
                        .frame(height: 100)
                        .cornerRadius(20)
                        .padding()
                    
                    Button(action: {
                        classify()
                    }){
                        Text("Deviner le sentiment")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                    }
                    .background(.blue)
                    .cornerRadius(20)
                    .padding()
                    
                }
                .background(.purple)
                .cornerRadius(20)
                .padding()
                
                if let outputSentiment{
                    VStack{
                        Text(outputSentiment.getEmoji())
                        Text(outputSentiment.rawValue)
                    }
                    .frame(width: 275)
                    .padding()
                    .background(outputSentiment.getColor())
                    .cornerRadius(20)
                }
                
            }.navigationBarTitle("🧠 IA du futur")
        }
    }
}

#Preview {
    ContentView()
}
