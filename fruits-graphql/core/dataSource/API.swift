// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FruitDetailQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FruitDetail($fruitId: ID!) {
      fruit(id: $fruitId) {
        __typename
        id
        fruit_name
        origin
        description
      }
    }
    """

  public let operationName: String = "FruitDetail"

  public var fruitId: GraphQLID

  public init(fruitId: GraphQLID) {
    self.fruitId = fruitId
  }

  public var variables: GraphQLMap? {
    return ["fruitId": fruitId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("fruit", arguments: ["id": GraphQLVariable("fruitId")], type: .object(Fruit.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(fruit: Fruit? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "fruit": fruit.flatMap { (value: Fruit) -> ResultMap in value.resultMap }])
    }

    public var fruit: Fruit? {
      get {
        return (resultMap["fruit"] as? ResultMap).flatMap { Fruit(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "fruit")
      }
    }

    public struct Fruit: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Fruit"]

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
        self.init(unsafeResultMap: ["__typename": "Fruit", "id": id, "fruit_name": fruitName, "origin": origin, "description": description])
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

public final class FruitListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FruitList {
      fruits {
        __typename
        ...FruitFragment
      }
    }
    """

  public let operationName: String = "FruitList"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + FruitFragment.fragmentDefinition)
    return document
  }

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
          GraphQLFragmentSpread(FruitFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, fruitName: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Fruits", "id": id, "fruit_name": fruitName])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fruitFragment: FruitFragment {
          get {
            return FruitFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class AddFruitMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddFruit($addFruitId: ID!, $scientificName: String!, $treeName: String!, $fruitName: String!, $family: String!, $origin: String!, $description: String!, $bloom: String!, $maturationFruit: String!, $lifeCycle: String!, $climaticZone: String!) {
      addFruit(
        id: $addFruitId
        scientific_name: $scientificName
        tree_name: $treeName
        fruit_name: $fruitName
        family: $family
        origin: $origin
        description: $description
        bloom: $bloom
        maturation_fruit: $maturationFruit
        life_cycle: $lifeCycle
        climatic_zone: $climaticZone
      ) {
        __typename
        ...FruitFragment
      }
    }
    """

  public let operationName: String = "AddFruit"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + FruitFragment.fragmentDefinition)
    return document
  }

  public var addFruitId: GraphQLID
  public var scientificName: String
  public var treeName: String
  public var fruitName: String
  public var family: String
  public var origin: String
  public var description: String
  public var bloom: String
  public var maturationFruit: String
  public var lifeCycle: String
  public var climaticZone: String

  public init(addFruitId: GraphQLID, scientificName: String, treeName: String, fruitName: String, family: String, origin: String, description: String, bloom: String, maturationFruit: String, lifeCycle: String, climaticZone: String) {
    self.addFruitId = addFruitId
    self.scientificName = scientificName
    self.treeName = treeName
    self.fruitName = fruitName
    self.family = family
    self.origin = origin
    self.description = description
    self.bloom = bloom
    self.maturationFruit = maturationFruit
    self.lifeCycle = lifeCycle
    self.climaticZone = climaticZone
  }

  public var variables: GraphQLMap? {
    return ["addFruitId": addFruitId, "scientificName": scientificName, "treeName": treeName, "fruitName": fruitName, "family": family, "origin": origin, "description": description, "bloom": bloom, "maturationFruit": maturationFruit, "lifeCycle": lifeCycle, "climaticZone": climaticZone]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addFruit", arguments: ["id": GraphQLVariable("addFruitId"), "scientific_name": GraphQLVariable("scientificName"), "tree_name": GraphQLVariable("treeName"), "fruit_name": GraphQLVariable("fruitName"), "family": GraphQLVariable("family"), "origin": GraphQLVariable("origin"), "description": GraphQLVariable("description"), "bloom": GraphQLVariable("bloom"), "maturation_fruit": GraphQLVariable("maturationFruit"), "life_cycle": GraphQLVariable("lifeCycle"), "climatic_zone": GraphQLVariable("climaticZone")], type: .nonNull(.object(AddFruit.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addFruit: AddFruit) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addFruit": addFruit.resultMap])
    }

    public var addFruit: AddFruit {
      get {
        return AddFruit(unsafeResultMap: resultMap["addFruit"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addFruit")
      }
    }

    public struct AddFruit: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Fruits"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(FruitFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, fruitName: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Fruits", "id": id, "fruit_name": fruitName])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fruitFragment: FruitFragment {
          get {
            return FruitFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct FruitFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment FruitFragment on Fruits {
      __typename
      id
      fruit_name
    }
    """

  public static let possibleTypes: [String] = ["Fruits"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .scalar(GraphQLID.self)),
      GraphQLField("fruit_name", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID? = nil, fruitName: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Fruits", "id": id, "fruit_name": fruitName])
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
}
