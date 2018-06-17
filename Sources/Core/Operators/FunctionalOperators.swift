import Foundation

precedencegroup ForwardPipe {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

infix operator |> : ForwardPipe

public func |> <T, U>(value: T, function: ((T) -> U)) -> U {
    return function(value)
}
