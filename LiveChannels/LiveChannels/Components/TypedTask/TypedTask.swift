//
//  TypedTask.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 23/4/23.
//

import Foundation

public typealias AnyTask = TypedTask<Any>
public typealias KeyedTask<K: Hashable> = [K: AnyTask]

@dynamicMemberLookup
public class TypedTask<T>: Equatable {
    public enum Status {
        case idle
        case running
        case success
        case error
    }

    public let status: Status
    public let data: T?
    public let error: Error?
    public let initDate = Date()

    public init(status: Status = .idle,
                data: T? = nil,
                error: Error? = nil) {
        self.status = status
        self.data = data
        self.error = error
    }

    public static func idle() -> AnyTask {
        AnyTask(status: .idle)
    }

    public static func running() -> AnyTask {
        AnyTask(status: .running)
    }

    public static func success<T>(_ data: T? = nil) -> TypedTask<T> {
        TypedTask<T>(status: .success, data: data)
    }

    public static func success() -> AnyTask {
        AnyTask(status: .success)
    }

    public static func failure(_ error: Error) -> AnyTask {
        AnyTask(status: .error, error: error)
    }

    public var isRunning: Bool {
        status == .running
    }

    public var isCompleted: Bool {
        status == .success || status == .error
    }

    public var isSuccessful: Bool {
        status == .success
    }

    public var isFailure: Bool {
        status == .error
    }

    private var properties: [String: Any] = [:]

    public subscript<Value>(dynamicMember member: String) -> Value? {
        get {
            properties[member] as? Value
        }
        set {
            properties[member] = newValue
        }
    }

    public static func == (lhs: TypedTask<T>, rhs: TypedTask<T>) -> Bool {
        lhs.status == rhs.status && lhs.initDate == rhs.initDate
    }
}
