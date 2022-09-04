//
//  WebService.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import Foundation

enum NetworkError: Error {
  case invalidResponse
}

class WebService {
  func getQuotes(url: URL) async throws -> [Quote] {
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }
    return try JSONDecoder().decode([Quote].self, from: data)
  }
}
