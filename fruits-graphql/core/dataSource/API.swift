// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FruitListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FruitList {
      fruits {
        __typename
        id
        fruit_name
        origin
        description
      }
    }
    """

  public let operationName: String = "FruitList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("fruits", type: .list(.object(Fruit.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(fruits: [Fruit?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "fruits": fruits.flatMap { (value: [Fruit?]) -> [ResultMap?] in value.map { (value: Fruit?) -> ResultMap? in value.flatMap { (value: Fruit) -> ResultMap in value.resultMap } } }])
    }

    public var fruits: [Fruit?]? {
      get {
        return (resultMap["fruits"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Fruit?] in value.map { (value: ResultMap?) -> Fruit? in value.flatMap { (value: ResultMap) -> Fruit in Fruit(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Fruit?]) -> [ResultMap?] in value.map { (value: Fruit?) -> ResultMap? in value.flatMap { (value: Fruit) -> ResultMap in value.resultMap } } }, forKey: "fruits")
      }
    }

    public struct Fruit: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Fruits"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(GraphQLID.self)),
          GraphQLField("fruit_name", type: .scalar(String.self)),
          GraphQLField("origin", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, fruitName: String? = nil, origin: String? = nil, description: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Fruits", "id": id, "fruit_name": fruitName, "origin": origin, "description": description])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return resultMap["id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var fruitName: String? {
        get {
          return resultMap["fruit_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fruit_name")
        }
      }

      public var origin: String? {
        get {
          return resultMap["origin"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "origin")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}
