//
//  UserDefault.swift
//  Swissors
//
//  Created by viktor.volkov on 4/15/22.
//

import Foundation

/// Враппер оборачивает работу с UserDefaults
///
/// Умеет сохранять любые Codable сущности
///
/// **Важно!** При наличии существующих значений в случае перехода необходимо
/// осуществить миграцию, так как враппер работает через сериализацию
///
/// Пример работы c враппером:
///
///         // Объявить `enum`, в котором будет храниться список ключей
///         enum UserDefaultKey: String {
///             case userId
///             case isAuthorized
///             case isFirstLaunch
///         }
///
///         // Объявить enum для хранения врапперов
///         enum UserDefaults {
///
///             @UserDefault(key: UserDefaultKey.userId.rawValue)
///             static var userId: String
///
///             @UserDefault(key: UserDefaultKey.isAuthorized.rawValue, defaultValue: false)
///             static var isAuthorized: Bool
///
///             @UserDefault(key: UserDefaultKey.isFirstLaunch.rawValue, defaultValue: false)
///             static var isFirstLaunch: Bool
///         }
///
///         // Обращаться в коде как к обычным переменным
///
///         if UserDefaults.isFirstLaunch {
///             UserDefaults.isFirstLaunch = false
///             showOnboarding()
///         }
@propertyWrapper
public struct UserDefault<Value: Codable> {

    let key: String
    let defaultValue: Value
    let storage: UserDefaults
    
    /// Объявляет новую переменную, которая будет храниться в `UserDefaults`
    ///
    ///         @UserDefault(key: "isAuthorized", defaultValue: false)
    ///         var isAuthorized: Bool
    ///
    /// - Parameters:
    ///   - key: Ключ, по которому будет храниться объект
    ///   - defaultValue: значение по умолчанию
    ///   - storage: Тип хранилища, которое будет использоваться
    ///
    public init(key: String, defaultValue: Value, storage: Kind = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage.storage
    }
    
    public var wrappedValue: Value {
        get {
            if let data = storage.data(forKey: key),
               let value: Value = data.decode() {
                return value
            }
            return defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                if let data = newValue.encode() {
                    storage.set(data, forKey: key)
                }
            }
        }
    }
    
    /// Тип хранилища
    public enum Kind {
        
        /// UserDefaults.standard
        case standard
        
        /// UserDefaults(suiteName: suiteName)
        case shared(suiteName: String)

        var storage: UserDefaults {
            switch self {
            case .standard:
                return .standard
            case let .shared(suiteName):
                return UserDefaults(suiteName: suiteName) ?? .standard
            }
        }
    }
}

extension UserDefault where Value: ExpressibleByNilLiteral {
    
    /// Враппер для опциональных типов с значением по умолчанию, равным nil
    ///
    ///         @UserDefault(key: "userId")
    ///         var userId: String?
    ///
    /// - Parameters:
    ///   - key: Ключ, по которому будет храниться объект
    ///   - storage: Тип хранилища, которое будет использоваться
    ///
    public init(key: String, storage: Kind = .standard) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }
}

private extension Encodable {

    func encode() -> Data? {
        try? JSONEncoder().encode([self])
    }
}

private extension Data {

    func decode<T: Decodable>() -> T? {
        (try? JSONDecoder().decode([T].self, from: self))?.first
    }
}

private protocol AnyOptional {

    var isNil: Bool { get }
}

extension Optional: AnyOptional {

    var isNil: Bool { self == nil }
}
