// h/t https://gist.github.com/IanKeen/4348694dd62ac297ecf0d866164edb72

import Foundation

extension Decodable {
  public static func empty() -> Self {
    do {
      return try Self(from: EmptyDecoder())
    } catch {
      fatalError("can't create an empty \(self.self)!")
    }
  }
}

private class EmptyDecoder: Decoder {
  let codingPath: [CodingKey] = []
  let userInfo: [CodingUserInfoKey: Any] = [:]
  
  init() { }
  
  func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
    return .init(KeyedContainer<Key>())
  }
  
  func unkeyedContainer() throws -> UnkeyedDecodingContainer {
    return UnkeyedContainer()
  }
  
  func singleValueContainer() throws -> SingleValueDecodingContainer {
    return SingleValueContainer()
  }
  
  struct KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
    let allKeys: [Key] = []
    let codingPath: [CodingKey] = []
    
    init() { }
    
    func contains(_ key: Key) -> Bool {
      return true
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
      return true
    }
    
    func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
      return T.empty()
    }
    
    func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
      return .init(KeyedContainer<NestedKey>())
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
      return UnkeyedContainer()
    }
    
    func superDecoder() throws -> Decoder {
      return EmptyDecoder()
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
      return EmptyDecoder()
    }
  }
  
  struct UnkeyedContainer: UnkeyedDecodingContainer {
    let codingPath: [CodingKey] = []
    var isAtEnd: Bool { return true }
    var count: Int? = 0
    var currentIndex: Int = 0
    
    init() { }
    
    mutating func decodeNil() throws -> Bool {
      return true
    }
    
    mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
      return T.empty()
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
      return .init(KeyedContainer<NestedKey>())
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
      return UnkeyedContainer()
    }
    
    mutating func superDecoder() throws -> Decoder {
      return EmptyDecoder()
    }
  }
  
  struct SingleValueContainer: SingleValueDecodingContainer {
    let codingPath: [CodingKey] = []
    
    init() { }
    
    func decodeNil() -> Bool { return true }
    func decode(_ type: Bool.Type) throws -> Bool { return true }
    func decode(_ type: String.Type) throws -> String { return "" }
    func decode(_ type: Double.Type) throws -> Double { return 0 }
    func decode(_ type: Float.Type) throws -> Float { return 0 }
    func decode(_ type: Int.Type) throws -> Int { return 0 }
    func decode(_ type: Int8.Type) throws -> Int8 { return 0 }
    func decode(_ type: Int16.Type) throws -> Int16 { return 0 }
    func decode(_ type: Int32.Type) throws -> Int32 { return 0 }
    func decode(_ type: Int64.Type) throws -> Int64 { return 0 }
    func decode(_ type: UInt.Type) throws -> UInt { return 0 }
    func decode(_ type: UInt8.Type) throws -> UInt8 { return 0 }
    func decode(_ type: UInt16.Type) throws -> UInt16 { return 0 }
    func decode(_ type: UInt32.Type) throws -> UInt32 { return 0 }
    func decode(_ type: UInt64.Type) throws -> UInt64 { return 0 }
    func decode<T: Decodable>(_ type: T.Type) throws -> T { return T.empty() }
  }
}
