//
//  ApolloNetwork.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation
import Apollo

class ApolloNetwork {
  static let shared = ApolloNetwork()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://fruits-api.netlify.app/graphql")!)
}
