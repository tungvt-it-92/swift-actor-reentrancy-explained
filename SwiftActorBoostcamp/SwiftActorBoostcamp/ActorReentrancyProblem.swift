//
//  ActorReentrancyProblem.swift
//  SwiftActorBoostcamp
//

class BankAccountV1 {
    var balance: Int = 10000
    
    func withdraw(_ amount: Int) async {
        if amount > balance {
            return
        }
        balance -= amount
    }
}

actor BankAccountV2 {
    var balance: Int = 10000
    
    func withdraw(_ amount: Int) async {
        if amount > balance {
            return
        }
        balance -= amount
    }
}

actor BankAccountWithActorButReentrancy {
    var balance: Int = 10000
    
    func withdraw(_ amount: Int) async {
        
        if amount > balance {
            return
        }
        
        await self.verifyUserID() // 👈 suspension point
        
        balance -= amount
    }
    
    func verifyUserID() async {
        try? await Task.sleep(for: .milliseconds(200)) // 👉 Simulate asynchronous action
    }
}

actor BankAccountV3 {
    var balance: Int = 10000
    
    func withdraw(_ amount: Int) async {
        await self.verifyUserID() // 👈 suspension point
        
        if amount > balance {
            return
        }
        
        balance -= amount
    }
    
    func verifyUserID() async {
        try? await Task.sleep(for: .milliseconds(200)) // 👉 Simulate asynchronous action
    }
}
