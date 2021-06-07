import Foundation

final class CallStation {
    private var userBase = [User]()
    private var baseCalls = [Call]()
}

extension CallStation: Station {
    func users() -> [User] {
        return userBase
    }
    
    func add(user: User) {
        guard !userBase.contains(user) else {
            return
        }
        userBase.append(user)
    }
    
    func remove(user: User) {
        if let index = userBase.firstIndex(of: user) {
            userBase.remove(at: index)
        }
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        
        case .start(from: let user1, to: let user2):
            let call  = Call(id: UUID(), incomingUser: user2, outgoingUser: user1, status: .calling)
            baseCalls.append(call)
            return call.id
            
        case .answer(from: let user):
            if let call = baseCalls.filter({$0.incomingUser.id == user.id}).first {
            let answerCall = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .talk)
                if let index = baseCalls.firstIndex(where: {$0.id == call.id}) {
                    baseCalls[index] = answerCall
                    return answerCall.id
                }
                
            }
            return nil
            
        case .end(from: let user):
            if let call = baseCalls.filter({$0.outgoingUser.id == user.id || $0.outgoingUser.id == user.id}).first {
                let answerCall = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .end))
                    if let index = baseCalls.firstIndex(where: {$0.id == call.id}) {
                        baseCalls[index] = answerCall
                        return answerCall.id
                    }
            }
            return nil
        }
    }
    
    func calls() -> [Call] {
        return baseCalls
    }
    
    func calls(user: User) -> [Call] {
        []
    }
    
    func call(id: CallID) -> Call? {
        nil
    }
    
    func currentCall(user: User) -> Call? {
        return baseCalls.filter {($0.incomingUser.id == user.id || $0.outgoingUser.id == user.id) && ($0.status == .talk || $0.status == .calling)}.first
    }
}
