import Foundation
import RxSwift
import ReactorKit

class AuthReactor: Reactor {
    let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    enum Action {
        case signIn(email: String)
    }

    enum Mutation {
        case loading
        case signedIn
        case error(message: String)
    }

    struct State {
        var isLoading = false
        var signedIn  = false
        var error: String?
    }

    func mutate(action: AuthReactor.Action) -> Observable<AuthReactor.Mutation> {
        switch action {
        case Action.signIn(email: let email):
            return authService.sendVerification(toEmail: email)
                .materialize()
                .map({ (event) -> Mutation in
                    if let error = event.error {
                        return .error(message: error.localizedDescription)
                    }
                    return .signedIn
                }).startWith(.loading)
        }
    }

    func transform(mutation: Observable<AuthReactor.Mutation>) -> Observable<AuthReactor.Mutation> {
        return mutation.debug()
    }

    func transform(state: Observable<AuthReactor.State>) -> Observable<AuthReactor.State> {
        return state.debug()
    }

    func reduce(state: AuthReactor.State, mutation: AuthReactor.Mutation) -> AuthReactor.State {
        var state = state
        switch mutation {

        case .loading:
            state.isLoading = true
            state.error = nil

        case .signedIn:
            state.isLoading = false
            state.signedIn  = true
            state.error = nil

        case .error(let message):
            state.isLoading = false
            state.error = message
        }

        return state
    }

    let initialState: State = State()
}
