//
//  ContentView.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel: QuotesViewModel
  
  init(viewModel: QuotesViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
    var body: some View {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Text(self.viewModel.quote.text).fontWeight(.bold).multilineTextAlignment(.leading).padding(.all, 12.0).frame(width: nil, height: 130.0).task {
            await viewModel.giveMeAQuote()
          }
          Divider()
            .padding(.bottom, 5.0)
          HStack {
            Text("© \(self.viewModel.quote.author)").fontWeight(.thin).foregroundColor(Color.gray).multilineTextAlignment(.leading).padding([.leading, .bottom], 12.0)
            Spacer()
              
            MenuButton("Menu") {
              Button("Next quote") {
                Task {
                  await viewModel.giveMeAQuote()
                }
              }
              Button("Quit") {
                NSApp.terminate(self)
              }
            }
            .padding([.bottom, .trailing], 12.0)
            .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)

          }
        }
      }.frame(width: 320)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(viewModel: QuotesViewModel())
    }
}
