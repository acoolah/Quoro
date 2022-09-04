//
//  QuoteViewModel.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import Foundation

@MainActor
class QuotesViewModel: ObservableObject {
  
  @Published
  var quote: QuoteViewModel = QuoteViewModel(quote: Quote(text: "Empty quote", author: "Unknown"))
  
  func giveMeAQuote() async {
    do {
      let quotes = try await WebService().getQuotes(url: Constants.URLs.quotes)
      self.quote = quotes.map(QuoteViewModel.init).randomElement()!
    } catch {
      print(error)
    }
  }
}

struct QuoteViewModel {
  private var quote: Quote
  
  init(quote: Quote) {
    self.quote = quote
  }
  
  var text: String {
    quote.text
  }
  
  var author: String {
    quote.author ?? "Unknown"
  }
}
