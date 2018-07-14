import Foundation

protocol Coordinator {
    var uuid: String { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func remove(_ coordinator: Coordinator)
}

extension Coordinator {

    func remove(_ coordinator: Coordinator) {

    }
}
