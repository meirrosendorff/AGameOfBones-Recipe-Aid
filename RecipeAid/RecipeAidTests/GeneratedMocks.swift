// MARK: - Mocks generated from file: RecipeAid/Services/Protocols/UserServicesProtocol.swift at 2019-07-11 06:45:34 +0000

//
//  UserServicesProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Cuckoo
@testable import RecipeAid

import Foundation
import When


 class MockUserServicesProtocol: UserServicesProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = UserServicesProtocol
    
     typealias Stubbing = __StubbingProxy_UserServicesProtocol
     typealias Verification = __VerificationProxy_UserServicesProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: UserServicesProtocol?

     func enableDefaultImplementation(_ stub: UserServicesProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func attemptLogin(username: String, password: String, onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)  {
        
    return cuckoo_manager.call("attemptLogin(username: String, password: String, onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)",
            parameters: (username, password, onComplete),
            escapingParameters: (username, password, onComplete),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.attemptLogin(username: username, password: password, onComplete: onComplete))
        
    }
    
    
    
     func getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void)  {
        
    return cuckoo_manager.call("getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void)",
            parameters: (token, onComplete),
            escapingParameters: (token, onComplete),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getUserDetails(token: token, onComplete: onComplete))
        
    }
    
    
    
     func logUserOut()  {
        
    return cuckoo_manager.call("logUserOut()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.logUserOut())
        
    }
    
    
    
     func setUserToLoggedIn(_ user: AuthenticatedUser)  {
        
    return cuckoo_manager.call("setUserToLoggedIn(_: AuthenticatedUser)",
            parameters: (user),
            escapingParameters: (user),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setUserToLoggedIn(user))
        
    }
    
    
    
     func setUserDetails(details: UserDetails)  {
        
    return cuckoo_manager.call("setUserDetails(details: UserDetails)",
            parameters: (details),
            escapingParameters: (details),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setUserDetails(details: details))
        
    }
    
    
    
     func getUserDetails() -> UserDetails? {
        
    return cuckoo_manager.call("getUserDetails() -> UserDetails?",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getUserDetails())
        
    }
    
    
    
     func getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void)  {
        
    return cuckoo_manager.call("getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void)",
            parameters: (onComplete),
            escapingParameters: (onComplete),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getProfilePic(onComplete: onComplete))
        
    }
    
    
    
     func FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser> {
        
    return cuckoo_manager.call("FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser>",
            parameters: (username, password),
            escapingParameters: (username, password),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.FPAttemptLogin(username: username, password: password))
        
    }
    
    
    
     func FPGetUserDetails(token: String) -> Promise<UserDetails> {
        
    return cuckoo_manager.call("FPGetUserDetails(token: String) -> Promise<UserDetails>",
            parameters: (token),
            escapingParameters: (token),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.FPGetUserDetails(token: token))
        
    }
    

	 struct __StubbingProxy_UserServicesProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func attemptLogin<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(username: M1, password: M2, onComplete: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == (Swift.Result<AuthenticatedUser, RecipeError>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)>] = [wrap(matchable: username) { $0.0 }, wrap(matchable: password) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "attemptLogin(username: String, password: String, onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getUserDetails<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(token: M1, onComplete: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, (Swift.Result<UserDetails, RecipeError>) -> Void)> where M1.MatchedType == String, M2.MatchedType == (Swift.Result<UserDetails, RecipeError>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (Swift.Result<UserDetails, RecipeError>) -> Void)>] = [wrap(matchable: token) { $0.0 }, wrap(matchable: onComplete) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func logUserOut() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "logUserOut()", parameterMatchers: matchers))
	    }
	    
	    func setUserToLoggedIn<M1: Cuckoo.Matchable>(_ user: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AuthenticatedUser)> where M1.MatchedType == AuthenticatedUser {
	        let matchers: [Cuckoo.ParameterMatcher<(AuthenticatedUser)>] = [wrap(matchable: user) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "setUserToLoggedIn(_: AuthenticatedUser)", parameterMatchers: matchers))
	    }
	    
	    func setUserDetails<M1: Cuckoo.Matchable>(details: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(UserDetails)> where M1.MatchedType == UserDetails {
	        let matchers: [Cuckoo.ParameterMatcher<(UserDetails)>] = [wrap(matchable: details) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "setUserDetails(details: UserDetails)", parameterMatchers: matchers))
	    }
	    
	    func getUserDetails() -> Cuckoo.ProtocolStubFunction<(), UserDetails?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "getUserDetails() -> UserDetails?", parameterMatchers: matchers))
	    }
	    
	    func getProfilePic<M1: Cuckoo.Matchable>(onComplete: M1) -> Cuckoo.ProtocolStubNoReturnFunction<((Swift.Result<Data, RecipeError>) -> Void)> where M1.MatchedType == (Swift.Result<Data, RecipeError>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<((Swift.Result<Data, RecipeError>) -> Void)>] = [wrap(matchable: onComplete) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func FPAttemptLogin<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(username: M1, password: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Promise<AuthenticatedUser>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: username) { $0.0 }, wrap(matchable: password) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser>", parameterMatchers: matchers))
	    }
	    
	    func FPGetUserDetails<M1: Cuckoo.Matchable>(token: M1) -> Cuckoo.ProtocolStubFunction<(String), Promise<UserDetails>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: token) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUserServicesProtocol.self, method: "FPGetUserDetails(token: String) -> Promise<UserDetails>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_UserServicesProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func attemptLogin<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(username: M1, password: M2, onComplete: M3) -> Cuckoo.__DoNotUse<(String, String, (Swift.Result<AuthenticatedUser, RecipeError>) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == (Swift.Result<AuthenticatedUser, RecipeError>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)>] = [wrap(matchable: username) { $0.0 }, wrap(matchable: password) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return cuckoo_manager.verify("attemptLogin(username: String, password: String, onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getUserDetails<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(token: M1, onComplete: M2) -> Cuckoo.__DoNotUse<(String, (Swift.Result<UserDetails, RecipeError>) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == (Swift.Result<UserDetails, RecipeError>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (Swift.Result<UserDetails, RecipeError>) -> Void)>] = [wrap(matchable: token) { $0.0 }, wrap(matchable: onComplete) { $0.1 }]
	        return cuckoo_manager.verify("getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func logUserOut() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("logUserOut()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setUserToLoggedIn<M1: Cuckoo.Matchable>(_ user: M1) -> Cuckoo.__DoNotUse<(AuthenticatedUser), Void> where M1.MatchedType == AuthenticatedUser {
	        let matchers: [Cuckoo.ParameterMatcher<(AuthenticatedUser)>] = [wrap(matchable: user) { $0 }]
	        return cuckoo_manager.verify("setUserToLoggedIn(_: AuthenticatedUser)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setUserDetails<M1: Cuckoo.Matchable>(details: M1) -> Cuckoo.__DoNotUse<(UserDetails), Void> where M1.MatchedType == UserDetails {
	        let matchers: [Cuckoo.ParameterMatcher<(UserDetails)>] = [wrap(matchable: details) { $0 }]
	        return cuckoo_manager.verify("setUserDetails(details: UserDetails)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getUserDetails() -> Cuckoo.__DoNotUse<(), UserDetails?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getUserDetails() -> UserDetails?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getProfilePic<M1: Cuckoo.Matchable>(onComplete: M1) -> Cuckoo.__DoNotUse<((Swift.Result<Data, RecipeError>) -> Void), Void> where M1.MatchedType == (Swift.Result<Data, RecipeError>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<((Swift.Result<Data, RecipeError>) -> Void)>] = [wrap(matchable: onComplete) { $0 }]
	        return cuckoo_manager.verify("getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func FPAttemptLogin<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(username: M1, password: M2) -> Cuckoo.__DoNotUse<(String, String), Promise<AuthenticatedUser>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: username) { $0.0 }, wrap(matchable: password) { $0.1 }]
	        return cuckoo_manager.verify("FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func FPGetUserDetails<M1: Cuckoo.Matchable>(token: M1) -> Cuckoo.__DoNotUse<(String), Promise<UserDetails>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: token) { $0 }]
	        return cuckoo_manager.verify("FPGetUserDetails(token: String) -> Promise<UserDetails>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class UserServicesProtocolStub: UserServicesProtocol {
    

    

    
     func attemptLogin(username: String, password: String, onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func logUserOut()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setUserToLoggedIn(_ user: AuthenticatedUser)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setUserDetails(details: UserDetails)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getUserDetails() -> UserDetails?  {
        return DefaultValueRegistry.defaultValue(for: (UserDetails?).self)
    }
    
     func getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser>  {
        return DefaultValueRegistry.defaultValue(for: (Promise<AuthenticatedUser>).self)
    }
    
     func FPGetUserDetails(token: String) -> Promise<UserDetails>  {
        return DefaultValueRegistry.defaultValue(for: (Promise<UserDetails>).self)
    }
    
}


// MARK: - Mocks generated from file: RecipeAid/Services/Services/CoreDataStorageRepo.swift at 2019-07-11 06:45:34 +0000

//
//  CoreDataStorageRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Cuckoo
@testable import RecipeAid

import CoreData
import Foundation
import UIKit


 class MockCoreDataStorageRepo: CoreDataStorageRepo, Cuckoo.ClassMock {
    
     typealias MocksType = CoreDataStorageRepo
    
     typealias Stubbing = __StubbingProxy_CoreDataStorageRepo
     typealias Verification = __VerificationProxy_CoreDataStorageRepo

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: CoreDataStorageRepo?

     func enableDefaultImplementation(_ stub: CoreDataStorageRepo) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var persistentContainer: NSPersistentContainer! {
        get {
            return cuckoo_manager.getter("persistentContainer",
                superclassCall:
                    
                    super.persistentContainer
                    ,
                defaultCall: __defaultImplStub!.persistentContainer)
        }
        
        set {
            cuckoo_manager.setter("persistentContainer",
                value: newValue,
                superclassCall:
                    
                    super.persistentContainer = newValue
                    ,
                defaultCall: __defaultImplStub!.persistentContainer = newValue)
        }
        
    }
    
    
    
     override var managedObjectContext: NSManagedObjectContext! {
        get {
            return cuckoo_manager.getter("managedObjectContext",
                superclassCall:
                    
                    super.managedObjectContext
                    ,
                defaultCall: __defaultImplStub!.managedObjectContext)
        }
        
    }
    
    
    
     override var managedContextSet: Bool {
        get {
            return cuckoo_manager.getter("managedContextSet",
                superclassCall:
                    
                    super.managedContextSet
                    ,
                defaultCall: __defaultImplStub!.managedContextSet)
        }
        
        set {
            cuckoo_manager.setter("managedContextSet",
                value: newValue,
                superclassCall:
                    
                    super.managedContextSet = newValue
                    ,
                defaultCall: __defaultImplStub!.managedContextSet = newValue)
        }
        
    }
    

    

    
    
    
     override func saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes)  {
        
    return cuckoo_manager.call("saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes)",
            parameters: (withRecipe, forDate, forMeal),
            escapingParameters: (withRecipe, forDate, forMeal),
            superclassCall:
                
                super.saveMeal(withRecipe: withRecipe, forDate: forDate, forMeal: forMeal)
                ,
            defaultCall: __defaultImplStub!.saveMeal(withRecipe: withRecipe, forDate: forDate, forMeal: forMeal))
        
    }
    
    
    
     override func getRecipeID(forDate date: Date, forMeal meal: MealTypes, onComplete: @escaping (String) -> Void)  {
        
    return cuckoo_manager.call("getRecipeID(forDate: Date, forMeal: MealTypes, onComplete: @escaping (String) -> Void)",
            parameters: (date, meal, onComplete),
            escapingParameters: (date, meal, onComplete),
            superclassCall:
                
                super.getRecipeID(forDate: date, forMeal: meal, onComplete: onComplete)
                ,
            defaultCall: __defaultImplStub!.getRecipeID(forDate: date, forMeal: meal, onComplete: onComplete))
        
    }
    
    
    
     override func getShoppingItems(forDate date: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)  {
        
    return cuckoo_manager.call("getShoppingItems(forDate: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)",
            parameters: (date, forDays, onComplete),
            escapingParameters: (date, forDays, onComplete),
            superclassCall:
                
                super.getShoppingItems(forDate: date, forDays: forDays, onComplete: onComplete)
                ,
            defaultCall: __defaultImplStub!.getShoppingItems(forDate: date, forDays: forDays, onComplete: onComplete))
        
    }
    
    
    
     override func updateShoppingItem(_ item: ShoppingItem)  {
        
    return cuckoo_manager.call("updateShoppingItem(_: ShoppingItem)",
            parameters: (item),
            escapingParameters: (item),
            superclassCall:
                
                super.updateShoppingItem(item)
                ,
            defaultCall: __defaultImplStub!.updateShoppingItem(item))
        
    }
    

	 struct __StubbingProxy_CoreDataStorageRepo: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var persistentContainer: Cuckoo.ClassToBeStubbedOptionalProperty<MockCoreDataStorageRepo, NSPersistentContainer> {
	        return .init(manager: cuckoo_manager, name: "persistentContainer")
	    }
	    
	    
	    var managedObjectContext: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockCoreDataStorageRepo, NSManagedObjectContext?> {
	        return .init(manager: cuckoo_manager, name: "managedObjectContext")
	    }
	    
	    
	    var managedContextSet: Cuckoo.ClassToBeStubbedProperty<MockCoreDataStorageRepo, Bool> {
	        return .init(manager: cuckoo_manager, name: "managedContextSet")
	    }
	    
	    
	    func saveMeal<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(withRecipe: M1, forDate: M2, forMeal: M3) -> Cuckoo.ClassStubNoReturnFunction<(Recipe, Date, MealTypes)> where M1.MatchedType == Recipe, M2.MatchedType == Date, M3.MatchedType == MealTypes {
	        let matchers: [Cuckoo.ParameterMatcher<(Recipe, Date, MealTypes)>] = [wrap(matchable: withRecipe) { $0.0 }, wrap(matchable: forDate) { $0.1 }, wrap(matchable: forMeal) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataStorageRepo.self, method: "saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes)", parameterMatchers: matchers))
	    }
	    
	    func getRecipeID<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(forDate date: M1, forMeal meal: M2, onComplete: M3) -> Cuckoo.ClassStubNoReturnFunction<(Date, MealTypes, (String) -> Void)> where M1.MatchedType == Date, M2.MatchedType == MealTypes, M3.MatchedType == (String) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, MealTypes, (String) -> Void)>] = [wrap(matchable: date) { $0.0 }, wrap(matchable: meal) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataStorageRepo.self, method: "getRecipeID(forDate: Date, forMeal: MealTypes, onComplete: @escaping (String) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getShoppingItems<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(forDate date: M1, forDays: M2, onComplete: M3) -> Cuckoo.ClassStubNoReturnFunction<(Date, Int, ([ShoppingItem]) -> Void)> where M1.MatchedType == Date, M2.MatchedType == Int, M3.MatchedType == ([ShoppingItem]) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, Int, ([ShoppingItem]) -> Void)>] = [wrap(matchable: date) { $0.0 }, wrap(matchable: forDays) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataStorageRepo.self, method: "getShoppingItems(forDate: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func updateShoppingItem<M1: Cuckoo.Matchable>(_ item: M1) -> Cuckoo.ClassStubNoReturnFunction<(ShoppingItem)> where M1.MatchedType == ShoppingItem {
	        let matchers: [Cuckoo.ParameterMatcher<(ShoppingItem)>] = [wrap(matchable: item) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataStorageRepo.self, method: "updateShoppingItem(_: ShoppingItem)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CoreDataStorageRepo: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var persistentContainer: Cuckoo.VerifyOptionalProperty<NSPersistentContainer> {
	        return .init(manager: cuckoo_manager, name: "persistentContainer", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var managedObjectContext: Cuckoo.VerifyReadOnlyProperty<NSManagedObjectContext?> {
	        return .init(manager: cuckoo_manager, name: "managedObjectContext", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var managedContextSet: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "managedContextSet", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func saveMeal<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(withRecipe: M1, forDate: M2, forMeal: M3) -> Cuckoo.__DoNotUse<(Recipe, Date, MealTypes), Void> where M1.MatchedType == Recipe, M2.MatchedType == Date, M3.MatchedType == MealTypes {
	        let matchers: [Cuckoo.ParameterMatcher<(Recipe, Date, MealTypes)>] = [wrap(matchable: withRecipe) { $0.0 }, wrap(matchable: forDate) { $0.1 }, wrap(matchable: forMeal) { $0.2 }]
	        return cuckoo_manager.verify("saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecipeID<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(forDate date: M1, forMeal meal: M2, onComplete: M3) -> Cuckoo.__DoNotUse<(Date, MealTypes, (String) -> Void), Void> where M1.MatchedType == Date, M2.MatchedType == MealTypes, M3.MatchedType == (String) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, MealTypes, (String) -> Void)>] = [wrap(matchable: date) { $0.0 }, wrap(matchable: meal) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return cuckoo_manager.verify("getRecipeID(forDate: Date, forMeal: MealTypes, onComplete: @escaping (String) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getShoppingItems<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(forDate date: M1, forDays: M2, onComplete: M3) -> Cuckoo.__DoNotUse<(Date, Int, ([ShoppingItem]) -> Void), Void> where M1.MatchedType == Date, M2.MatchedType == Int, M3.MatchedType == ([ShoppingItem]) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, Int, ([ShoppingItem]) -> Void)>] = [wrap(matchable: date) { $0.0 }, wrap(matchable: forDays) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return cuckoo_manager.verify("getShoppingItems(forDate: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateShoppingItem<M1: Cuckoo.Matchable>(_ item: M1) -> Cuckoo.__DoNotUse<(ShoppingItem), Void> where M1.MatchedType == ShoppingItem {
	        let matchers: [Cuckoo.ParameterMatcher<(ShoppingItem)>] = [wrap(matchable: item) { $0 }]
	        return cuckoo_manager.verify("updateShoppingItem(_: ShoppingItem)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CoreDataStorageRepoStub: CoreDataStorageRepo {
    
    
     override var persistentContainer: NSPersistentContainer! {
        get {
            return DefaultValueRegistry.defaultValue(for: (NSPersistentContainer?).self)
        }
        
        set { }
        
    }
    
    
     override var managedObjectContext: NSManagedObjectContext! {
        get {
            return DefaultValueRegistry.defaultValue(for: (NSManagedObjectContext?).self)
        }
        
    }
    
    
     override var managedContextSet: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    

    

    
     override func saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getRecipeID(forDate date: Date, forMeal meal: MealTypes, onComplete: @escaping (String) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getShoppingItems(forDate date: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func updateShoppingItem(_ item: ShoppingItem)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: RecipeAid/Services/Services/SettingsRepo.swift at 2019-07-11 06:45:34 +0000

//
//  SettingsRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Cuckoo
@testable import RecipeAid

import Foundation


 class MockSettingsRepo: SettingsRepo, Cuckoo.ClassMock {
    
     typealias MocksType = SettingsRepo
    
     typealias Stubbing = __StubbingProxy_SettingsRepo
     typealias Verification = __VerificationProxy_SettingsRepo

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: SettingsRepo?

     func enableDefaultImplementation(_ stub: SettingsRepo) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var userDefaults: UserDefaults {
        get {
            return cuckoo_manager.getter("userDefaults",
                superclassCall:
                    
                    super.userDefaults
                    ,
                defaultCall: __defaultImplStub!.userDefaults)
        }
        
        set {
            cuckoo_manager.setter("userDefaults",
                value: newValue,
                superclassCall:
                    
                    super.userDefaults = newValue
                    ,
                defaultCall: __defaultImplStub!.userDefaults = newValue)
        }
        
    }
    

    

    
    
    
     override func getRestrictions() -> [(String, Bool)] {
        
    return cuckoo_manager.call("getRestrictions() -> [(String, Bool)]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getRestrictions()
                ,
            defaultCall: __defaultImplStub!.getRestrictions())
        
    }
    
    
    
     override func setRestrictions(restrictions: [(String, Bool)])  {
        
    return cuckoo_manager.call("setRestrictions(restrictions: [(String, Bool)])",
            parameters: (restrictions),
            escapingParameters: (restrictions),
            superclassCall:
                
                super.setRestrictions(restrictions: restrictions)
                ,
            defaultCall: __defaultImplStub!.setRestrictions(restrictions: restrictions))
        
    }
    
    
    
     override func getCaloriesRange() -> (Int, Int) {
        
    return cuckoo_manager.call("getCaloriesRange() -> (Int, Int)",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getCaloriesRange()
                ,
            defaultCall: __defaultImplStub!.getCaloriesRange())
        
    }
    
    
    
     override func setCaloriesRange(calories: (Int, Int))  {
        
    return cuckoo_manager.call("setCaloriesRange(calories: (Int, Int))",
            parameters: (calories),
            escapingParameters: (calories),
            superclassCall:
                
                super.setCaloriesRange(calories: calories)
                ,
            defaultCall: __defaultImplStub!.setCaloriesRange(calories: calories))
        
    }
    
    
    
     override func getTimesRange() -> (Int, Int) {
        
    return cuckoo_manager.call("getTimesRange() -> (Int, Int)",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getTimesRange()
                ,
            defaultCall: __defaultImplStub!.getTimesRange())
        
    }
    
    
    
     override func setTimesRange(times: (Int, Int))  {
        
    return cuckoo_manager.call("setTimesRange(times: (Int, Int))",
            parameters: (times),
            escapingParameters: (times),
            superclassCall:
                
                super.setTimesRange(times: times)
                ,
            defaultCall: __defaultImplStub!.setTimesRange(times: times))
        
    }
    
    
    
     override func getUnwantedFoods() -> [String] {
        
    return cuckoo_manager.call("getUnwantedFoods() -> [String]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getUnwantedFoods()
                ,
            defaultCall: __defaultImplStub!.getUnwantedFoods())
        
    }
    
    
    
     override func setUnwatedFoods(foods: [String])  {
        
    return cuckoo_manager.call("setUnwatedFoods(foods: [String])",
            parameters: (foods),
            escapingParameters: (foods),
            superclassCall:
                
                super.setUnwatedFoods(foods: foods)
                ,
            defaultCall: __defaultImplStub!.setUnwatedFoods(foods: foods))
        
    }
    

	 struct __StubbingProxy_SettingsRepo: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var userDefaults: Cuckoo.ClassToBeStubbedProperty<MockSettingsRepo, UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefaults")
	    }
	    
	    
	    func getRestrictions() -> Cuckoo.ClassStubFunction<(), [(String, Bool)]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "getRestrictions() -> [(String, Bool)]", parameterMatchers: matchers))
	    }
	    
	    func setRestrictions<M1: Cuckoo.Matchable>(restrictions: M1) -> Cuckoo.ClassStubNoReturnFunction<([(String, Bool)])> where M1.MatchedType == [(String, Bool)] {
	        let matchers: [Cuckoo.ParameterMatcher<([(String, Bool)])>] = [wrap(matchable: restrictions) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "setRestrictions(restrictions: [(String, Bool)])", parameterMatchers: matchers))
	    }
	    
	    func getCaloriesRange() -> Cuckoo.ClassStubFunction<(), (Int, Int)> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "getCaloriesRange() -> (Int, Int)", parameterMatchers: matchers))
	    }
	    
	    func setCaloriesRange<M1: Cuckoo.Matchable>(calories: M1) -> Cuckoo.ClassStubNoReturnFunction<((Int, Int))> where M1.MatchedType == (Int, Int) {
	        let matchers: [Cuckoo.ParameterMatcher<((Int, Int))>] = [wrap(matchable: calories) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "setCaloriesRange(calories: (Int, Int))", parameterMatchers: matchers))
	    }
	    
	    func getTimesRange() -> Cuckoo.ClassStubFunction<(), (Int, Int)> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "getTimesRange() -> (Int, Int)", parameterMatchers: matchers))
	    }
	    
	    func setTimesRange<M1: Cuckoo.Matchable>(times: M1) -> Cuckoo.ClassStubNoReturnFunction<((Int, Int))> where M1.MatchedType == (Int, Int) {
	        let matchers: [Cuckoo.ParameterMatcher<((Int, Int))>] = [wrap(matchable: times) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "setTimesRange(times: (Int, Int))", parameterMatchers: matchers))
	    }
	    
	    func getUnwantedFoods() -> Cuckoo.ClassStubFunction<(), [String]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "getUnwantedFoods() -> [String]", parameterMatchers: matchers))
	    }
	    
	    func setUnwatedFoods<M1: Cuckoo.Matchable>(foods: M1) -> Cuckoo.ClassStubNoReturnFunction<([String])> where M1.MatchedType == [String] {
	        let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: foods) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsRepo.self, method: "setUnwatedFoods(foods: [String])", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SettingsRepo: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var userDefaults: Cuckoo.VerifyProperty<UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefaults", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func getRestrictions() -> Cuckoo.__DoNotUse<(), [(String, Bool)]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getRestrictions() -> [(String, Bool)]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setRestrictions<M1: Cuckoo.Matchable>(restrictions: M1) -> Cuckoo.__DoNotUse<([(String, Bool)]), Void> where M1.MatchedType == [(String, Bool)] {
	        let matchers: [Cuckoo.ParameterMatcher<([(String, Bool)])>] = [wrap(matchable: restrictions) { $0 }]
	        return cuckoo_manager.verify("setRestrictions(restrictions: [(String, Bool)])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getCaloriesRange() -> Cuckoo.__DoNotUse<(), (Int, Int)> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getCaloriesRange() -> (Int, Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setCaloriesRange<M1: Cuckoo.Matchable>(calories: M1) -> Cuckoo.__DoNotUse<((Int, Int)), Void> where M1.MatchedType == (Int, Int) {
	        let matchers: [Cuckoo.ParameterMatcher<((Int, Int))>] = [wrap(matchable: calories) { $0 }]
	        return cuckoo_manager.verify("setCaloriesRange(calories: (Int, Int))", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTimesRange() -> Cuckoo.__DoNotUse<(), (Int, Int)> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getTimesRange() -> (Int, Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setTimesRange<M1: Cuckoo.Matchable>(times: M1) -> Cuckoo.__DoNotUse<((Int, Int)), Void> where M1.MatchedType == (Int, Int) {
	        let matchers: [Cuckoo.ParameterMatcher<((Int, Int))>] = [wrap(matchable: times) { $0 }]
	        return cuckoo_manager.verify("setTimesRange(times: (Int, Int))", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getUnwantedFoods() -> Cuckoo.__DoNotUse<(), [String]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getUnwantedFoods() -> [String]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setUnwatedFoods<M1: Cuckoo.Matchable>(foods: M1) -> Cuckoo.__DoNotUse<([String]), Void> where M1.MatchedType == [String] {
	        let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: foods) { $0 }]
	        return cuckoo_manager.verify("setUnwatedFoods(foods: [String])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SettingsRepoStub: SettingsRepo {
    
    
     override var userDefaults: UserDefaults {
        get {
            return DefaultValueRegistry.defaultValue(for: (UserDefaults).self)
        }
        
        set { }
        
    }
    

    

    
     override func getRestrictions() -> [(String, Bool)]  {
        return DefaultValueRegistry.defaultValue(for: ([(String, Bool)]).self)
    }
    
     override func setRestrictions(restrictions: [(String, Bool)])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getCaloriesRange() -> (Int, Int)  {
        return DefaultValueRegistry.defaultValue(for: ((Int, Int)).self)
    }
    
     override func setCaloriesRange(calories: (Int, Int))   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTimesRange() -> (Int, Int)  {
        return DefaultValueRegistry.defaultValue(for: ((Int, Int)).self)
    }
    
     override func setTimesRange(times: (Int, Int))   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getUnwantedFoods() -> [String]  {
        return DefaultValueRegistry.defaultValue(for: ([String]).self)
    }
    
     override func setUnwatedFoods(foods: [String])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: RecipeAid/Services/Services/ShoppingListRepo.swift at 2019-07-11 06:45:34 +0000

//let gregorian = Calendar(identifier: .gregorian)
//  ShoppingListRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Cuckoo
@testable import RecipeAid

import Foundation


 class MockShoppingListRepo: ShoppingListRepo, Cuckoo.ClassMock {
    
     typealias MocksType = ShoppingListRepo
    
     typealias Stubbing = __StubbingProxy_ShoppingListRepo
     typealias Verification = __VerificationProxy_ShoppingListRepo

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ShoppingListRepo?

     func enableDefaultImplementation(_ stub: ShoppingListRepo) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var repo: PersistantStorageRepoProtocol {
        get {
            return cuckoo_manager.getter("repo",
                superclassCall:
                    
                    super.repo
                    ,
                defaultCall: __defaultImplStub!.repo)
        }
        
        set {
            cuckoo_manager.setter("repo",
                value: newValue,
                superclassCall:
                    
                    super.repo = newValue
                    ,
                defaultCall: __defaultImplStub!.repo = newValue)
        }
        
    }
    

    

    
    
    
     override func getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)  {
        
    return cuckoo_manager.call("getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)",
            parameters: (from, forDays, onComplete),
            escapingParameters: (from, forDays, onComplete),
            superclassCall:
                
                super.getShoppingList(from: from, forDays: forDays, onComplete: onComplete)
                ,
            defaultCall: __defaultImplStub!.getShoppingList(from: from, forDays: forDays, onComplete: onComplete))
        
    }
    
    
    
     override func saveItem(item: ShoppingItem)  {
        
    return cuckoo_manager.call("saveItem(item: ShoppingItem)",
            parameters: (item),
            escapingParameters: (item),
            superclassCall:
                
                super.saveItem(item: item)
                ,
            defaultCall: __defaultImplStub!.saveItem(item: item))
        
    }
    

	 struct __StubbingProxy_ShoppingListRepo: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var repo: Cuckoo.ClassToBeStubbedProperty<MockShoppingListRepo, PersistantStorageRepoProtocol> {
	        return .init(manager: cuckoo_manager, name: "repo")
	    }
	    
	    
	    func getShoppingList<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from: M1, forDays: M2, onComplete: M3) -> Cuckoo.ClassStubNoReturnFunction<(Date, Int, ([ShoppingItem]) -> Void)> where M1.MatchedType == Date, M2.MatchedType == Int, M3.MatchedType == ([ShoppingItem]) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, Int, ([ShoppingItem]) -> Void)>] = [wrap(matchable: from) { $0.0 }, wrap(matchable: forDays) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockShoppingListRepo.self, method: "getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func saveItem<M1: Cuckoo.Matchable>(item: M1) -> Cuckoo.ClassStubNoReturnFunction<(ShoppingItem)> where M1.MatchedType == ShoppingItem {
	        let matchers: [Cuckoo.ParameterMatcher<(ShoppingItem)>] = [wrap(matchable: item) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockShoppingListRepo.self, method: "saveItem(item: ShoppingItem)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ShoppingListRepo: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var repo: Cuckoo.VerifyProperty<PersistantStorageRepoProtocol> {
	        return .init(manager: cuckoo_manager, name: "repo", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func getShoppingList<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from: M1, forDays: M2, onComplete: M3) -> Cuckoo.__DoNotUse<(Date, Int, ([ShoppingItem]) -> Void), Void> where M1.MatchedType == Date, M2.MatchedType == Int, M3.MatchedType == ([ShoppingItem]) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, Int, ([ShoppingItem]) -> Void)>] = [wrap(matchable: from) { $0.0 }, wrap(matchable: forDays) { $0.1 }, wrap(matchable: onComplete) { $0.2 }]
	        return cuckoo_manager.verify("getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveItem<M1: Cuckoo.Matchable>(item: M1) -> Cuckoo.__DoNotUse<(ShoppingItem), Void> where M1.MatchedType == ShoppingItem {
	        let matchers: [Cuckoo.ParameterMatcher<(ShoppingItem)>] = [wrap(matchable: item) { $0 }]
	        return cuckoo_manager.verify("saveItem(item: ShoppingItem)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ShoppingListRepoStub: ShoppingListRepo {
    
    
     override var repo: PersistantStorageRepoProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (PersistantStorageRepoProtocol).self)
        }
        
        set { }
        
    }
    

    

    
     override func getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveItem(item: ShoppingItem)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: RecipeAid/Settings/Models/SettingsModel.swift at 2019-07-11 06:45:34 +0000

//
//  SettingsModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Cuckoo
@testable import RecipeAid

import Foundation


 class MockSettingsModel: SettingsModel, Cuckoo.ClassMock {
    
     typealias MocksType = SettingsModel
    
     typealias Stubbing = __StubbingProxy_SettingsModel
     typealias Verification = __VerificationProxy_SettingsModel

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: SettingsModel?

     func enableDefaultImplementation(_ stub: SettingsModel) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var profilePic: String {
        get {
            return cuckoo_manager.getter("profilePic",
                superclassCall:
                    
                    super.profilePic
                    ,
                defaultCall: __defaultImplStub!.profilePic)
        }
        
        set {
            cuckoo_manager.setter("profilePic",
                value: newValue,
                superclassCall:
                    
                    super.profilePic = newValue
                    ,
                defaultCall: __defaultImplStub!.profilePic = newValue)
        }
        
    }
    
    
    
     override var userName: String {
        get {
            return cuckoo_manager.getter("userName",
                superclassCall:
                    
                    super.userName
                    ,
                defaultCall: __defaultImplStub!.userName)
        }
        
        set {
            cuckoo_manager.setter("userName",
                value: newValue,
                superclassCall:
                    
                    super.userName = newValue
                    ,
                defaultCall: __defaultImplStub!.userName = newValue)
        }
        
    }
    
    
    
     override var emailAddress: String {
        get {
            return cuckoo_manager.getter("emailAddress",
                superclassCall:
                    
                    super.emailAddress
                    ,
                defaultCall: __defaultImplStub!.emailAddress)
        }
        
        set {
            cuckoo_manager.setter("emailAddress",
                value: newValue,
                superclassCall:
                    
                    super.emailAddress = newValue
                    ,
                defaultCall: __defaultImplStub!.emailAddress = newValue)
        }
        
    }
    
    
    
     override var minCalories: Int {
        get {
            return cuckoo_manager.getter("minCalories",
                superclassCall:
                    
                    super.minCalories
                    ,
                defaultCall: __defaultImplStub!.minCalories)
        }
        
        set {
            cuckoo_manager.setter("minCalories",
                value: newValue,
                superclassCall:
                    
                    super.minCalories = newValue
                    ,
                defaultCall: __defaultImplStub!.minCalories = newValue)
        }
        
    }
    
    
    
     override var maxCalories: Int {
        get {
            return cuckoo_manager.getter("maxCalories",
                superclassCall:
                    
                    super.maxCalories
                    ,
                defaultCall: __defaultImplStub!.maxCalories)
        }
        
        set {
            cuckoo_manager.setter("maxCalories",
                value: newValue,
                superclassCall:
                    
                    super.maxCalories = newValue
                    ,
                defaultCall: __defaultImplStub!.maxCalories = newValue)
        }
        
    }
    
    
    
     override var minTime: Int {
        get {
            return cuckoo_manager.getter("minTime",
                superclassCall:
                    
                    super.minTime
                    ,
                defaultCall: __defaultImplStub!.minTime)
        }
        
        set {
            cuckoo_manager.setter("minTime",
                value: newValue,
                superclassCall:
                    
                    super.minTime = newValue
                    ,
                defaultCall: __defaultImplStub!.minTime = newValue)
        }
        
    }
    
    
    
     override var maxTime: Int {
        get {
            return cuckoo_manager.getter("maxTime",
                superclassCall:
                    
                    super.maxTime
                    ,
                defaultCall: __defaultImplStub!.maxTime)
        }
        
        set {
            cuckoo_manager.setter("maxTime",
                value: newValue,
                superclassCall:
                    
                    super.maxTime = newValue
                    ,
                defaultCall: __defaultImplStub!.maxTime = newValue)
        }
        
    }
    
    
    
     override var unwantedFoods: [String] {
        get {
            return cuckoo_manager.getter("unwantedFoods",
                superclassCall:
                    
                    super.unwantedFoods
                    ,
                defaultCall: __defaultImplStub!.unwantedFoods)
        }
        
        set {
            cuckoo_manager.setter("unwantedFoods",
                value: newValue,
                superclassCall:
                    
                    super.unwantedFoods = newValue
                    ,
                defaultCall: __defaultImplStub!.unwantedFoods = newValue)
        }
        
    }
    
    
    
     override var restrictions: [(String, Bool)] {
        get {
            return cuckoo_manager.getter("restrictions",
                superclassCall:
                    
                    super.restrictions
                    ,
                defaultCall: __defaultImplStub!.restrictions)
        }
        
        set {
            cuckoo_manager.setter("restrictions",
                value: newValue,
                superclassCall:
                    
                    super.restrictions = newValue
                    ,
                defaultCall: __defaultImplStub!.restrictions = newValue)
        }
        
    }
    
    
    
     override var numRestrictions: Int {
        get {
            return cuckoo_manager.getter("numRestrictions",
                superclassCall:
                    
                    super.numRestrictions
                    ,
                defaultCall: __defaultImplStub!.numRestrictions)
        }
        
    }
    

    

    
    
    
     override func restrictionName(at pos: Int) -> String {
        
    return cuckoo_manager.call("restrictionName(at: Int) -> String",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.restrictionName(at: pos)
                ,
            defaultCall: __defaultImplStub!.restrictionName(at: pos))
        
    }
    
    
    
     override func restrictionIsSelected(at pos: Int) -> Bool {
        
    return cuckoo_manager.call("restrictionIsSelected(at: Int) -> Bool",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.restrictionIsSelected(at: pos)
                ,
            defaultCall: __defaultImplStub!.restrictionIsSelected(at: pos))
        
    }
    
    
    
     override func selectRestriction(at pos: Int)  {
        
    return cuckoo_manager.call("selectRestriction(at: Int)",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.selectRestriction(at: pos)
                ,
            defaultCall: __defaultImplStub!.selectRestriction(at: pos))
        
    }
    
    
    
     override func deselectRestriction(at pos: Int)  {
        
    return cuckoo_manager.call("deselectRestriction(at: Int)",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.deselectRestriction(at: pos)
                ,
            defaultCall: __defaultImplStub!.deselectRestriction(at: pos))
        
    }
    

	 struct __StubbingProxy_SettingsModel: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var profilePic: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, String> {
	        return .init(manager: cuckoo_manager, name: "profilePic")
	    }
	    
	    
	    var userName: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, String> {
	        return .init(manager: cuckoo_manager, name: "userName")
	    }
	    
	    
	    var emailAddress: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, String> {
	        return .init(manager: cuckoo_manager, name: "emailAddress")
	    }
	    
	    
	    var minCalories: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, Int> {
	        return .init(manager: cuckoo_manager, name: "minCalories")
	    }
	    
	    
	    var maxCalories: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, Int> {
	        return .init(manager: cuckoo_manager, name: "maxCalories")
	    }
	    
	    
	    var minTime: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, Int> {
	        return .init(manager: cuckoo_manager, name: "minTime")
	    }
	    
	    
	    var maxTime: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, Int> {
	        return .init(manager: cuckoo_manager, name: "maxTime")
	    }
	    
	    
	    var unwantedFoods: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, [String]> {
	        return .init(manager: cuckoo_manager, name: "unwantedFoods")
	    }
	    
	    
	    var restrictions: Cuckoo.ClassToBeStubbedProperty<MockSettingsModel, [(String, Bool)]> {
	        return .init(manager: cuckoo_manager, name: "restrictions")
	    }
	    
	    
	    var numRestrictions: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsModel, Int> {
	        return .init(manager: cuckoo_manager, name: "numRestrictions")
	    }
	    
	    
	    func restrictionName<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubFunction<(Int), String> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsModel.self, method: "restrictionName(at: Int) -> String", parameterMatchers: matchers))
	    }
	    
	    func restrictionIsSelected<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubFunction<(Int), Bool> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsModel.self, method: "restrictionIsSelected(at: Int) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func selectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsModel.self, method: "selectRestriction(at: Int)", parameterMatchers: matchers))
	    }
	    
	    func deselectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsModel.self, method: "deselectRestriction(at: Int)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SettingsModel: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var profilePic: Cuckoo.VerifyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "profilePic", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var userName: Cuckoo.VerifyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "userName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var emailAddress: Cuckoo.VerifyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "emailAddress", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var minCalories: Cuckoo.VerifyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "minCalories", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var maxCalories: Cuckoo.VerifyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "maxCalories", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var minTime: Cuckoo.VerifyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "minTime", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var maxTime: Cuckoo.VerifyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "maxTime", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var unwantedFoods: Cuckoo.VerifyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "unwantedFoods", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var restrictions: Cuckoo.VerifyProperty<[(String, Bool)]> {
	        return .init(manager: cuckoo_manager, name: "restrictions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var numRestrictions: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "numRestrictions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func restrictionName<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), String> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("restrictionName(at: Int) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func restrictionIsSelected<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), Bool> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("restrictionIsSelected(at: Int) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func selectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("selectRestriction(at: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func deselectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("deselectRestriction(at: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SettingsModelStub: SettingsModel {
    
    
     override var profilePic: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
        set { }
        
    }
    
    
     override var userName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
        set { }
        
    }
    
    
     override var emailAddress: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
        set { }
        
    }
    
    
     override var minCalories: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
        set { }
        
    }
    
    
     override var maxCalories: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
        set { }
        
    }
    
    
     override var minTime: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
        set { }
        
    }
    
    
     override var maxTime: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
        set { }
        
    }
    
    
     override var unwantedFoods: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
        set { }
        
    }
    
    
     override var restrictions: [(String, Bool)] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([(String, Bool)]).self)
        }
        
        set { }
        
    }
    
    
     override var numRestrictions: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
     override func restrictionName(at pos: Int) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func restrictionIsSelected(at pos: Int) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func selectRestriction(at pos: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func deselectRestriction(at pos: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: RecipeAid/Settings/ViewModels/SettingsViewModel.swift at 2019-07-11 06:45:34 +0000

//
//  SettingsViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Cuckoo
@testable import RecipeAid

import Foundation


 class MockSettingsViewModel: SettingsViewModel, Cuckoo.ClassMock {
    
     typealias MocksType = SettingsViewModel
    
     typealias Stubbing = __StubbingProxy_SettingsViewModel
     typealias Verification = __VerificationProxy_SettingsViewModel

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: SettingsViewModel?

     func enableDefaultImplementation(_ stub: SettingsViewModel) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var model: SettingsModel {
        get {
            return cuckoo_manager.getter("model",
                superclassCall:
                    
                    super.model
                    ,
                defaultCall: __defaultImplStub!.model)
        }
        
        set {
            cuckoo_manager.setter("model",
                value: newValue,
                superclassCall:
                    
                    super.model = newValue
                    ,
                defaultCall: __defaultImplStub!.model = newValue)
        }
        
    }
    
    
    
     override var repo: SettingsRepoProtocol {
        get {
            return cuckoo_manager.getter("repo",
                superclassCall:
                    
                    super.repo
                    ,
                defaultCall: __defaultImplStub!.repo)
        }
        
        set {
            cuckoo_manager.setter("repo",
                value: newValue,
                superclassCall:
                    
                    super.repo = newValue
                    ,
                defaultCall: __defaultImplStub!.repo = newValue)
        }
        
    }
    
    
    
     override var userServices: UserServicesProtocol {
        get {
            return cuckoo_manager.getter("userServices",
                superclassCall:
                    
                    super.userServices
                    ,
                defaultCall: __defaultImplStub!.userServices)
        }
        
        set {
            cuckoo_manager.setter("userServices",
                value: newValue,
                superclassCall:
                    
                    super.userServices = newValue
                    ,
                defaultCall: __defaultImplStub!.userServices = newValue)
        }
        
    }
    
    
    
     override var userName: String {
        get {
            return cuckoo_manager.getter("userName",
                superclassCall:
                    
                    super.userName
                    ,
                defaultCall: __defaultImplStub!.userName)
        }
        
    }
    
    
    
     override var emailAddress: String {
        get {
            return cuckoo_manager.getter("emailAddress",
                superclassCall:
                    
                    super.emailAddress
                    ,
                defaultCall: __defaultImplStub!.emailAddress)
        }
        
    }
    
    
    
     override var minCalories: String {
        get {
            return cuckoo_manager.getter("minCalories",
                superclassCall:
                    
                    super.minCalories
                    ,
                defaultCall: __defaultImplStub!.minCalories)
        }
        
    }
    
    
    
     override var maxCalories: String {
        get {
            return cuckoo_manager.getter("maxCalories",
                superclassCall:
                    
                    super.maxCalories
                    ,
                defaultCall: __defaultImplStub!.maxCalories)
        }
        
    }
    
    
    
     override var minTime: String {
        get {
            return cuckoo_manager.getter("minTime",
                superclassCall:
                    
                    super.minTime
                    ,
                defaultCall: __defaultImplStub!.minTime)
        }
        
    }
    
    
    
     override var maxTime: String {
        get {
            return cuckoo_manager.getter("maxTime",
                superclassCall:
                    
                    super.maxTime
                    ,
                defaultCall: __defaultImplStub!.maxTime)
        }
        
    }
    
    
    
     override var unwantedFoods: String {
        get {
            return cuckoo_manager.getter("unwantedFoods",
                superclassCall:
                    
                    super.unwantedFoods
                    ,
                defaultCall: __defaultImplStub!.unwantedFoods)
        }
        
    }
    
    
    
     override var numRestrictions: Int {
        get {
            return cuckoo_manager.getter("numRestrictions",
                superclassCall:
                    
                    super.numRestrictions
                    ,
                defaultCall: __defaultImplStub!.numRestrictions)
        }
        
    }
    

    

    
    
    
     override func setProfileData()  {
        
    return cuckoo_manager.call("setProfileData()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.setProfileData()
                ,
            defaultCall: __defaultImplStub!.setProfileData())
        
    }
    
    
    
     override func getProfilePic(onComplete: @escaping (Data?) -> Void)  {
        
    return cuckoo_manager.call("getProfilePic(onComplete: @escaping (Data?) -> Void)",
            parameters: (onComplete),
            escapingParameters: (onComplete),
            superclassCall:
                
                super.getProfilePic(onComplete: onComplete)
                ,
            defaultCall: __defaultImplStub!.getProfilePic(onComplete: onComplete))
        
    }
    
    
    
     override func restrictionName(at pos: Int) -> String {
        
    return cuckoo_manager.call("restrictionName(at: Int) -> String",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.restrictionName(at: pos)
                ,
            defaultCall: __defaultImplStub!.restrictionName(at: pos))
        
    }
    
    
    
     override func restrictionIsSelected(at pos: Int) -> Bool {
        
    return cuckoo_manager.call("restrictionIsSelected(at: Int) -> Bool",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.restrictionIsSelected(at: pos)
                ,
            defaultCall: __defaultImplStub!.restrictionIsSelected(at: pos))
        
    }
    
    
    
     override func selectRestriction(at pos: Int)  {
        
    return cuckoo_manager.call("selectRestriction(at: Int)",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.selectRestriction(at: pos)
                ,
            defaultCall: __defaultImplStub!.selectRestriction(at: pos))
        
    }
    
    
    
     override func deselectRestriction(at pos: Int)  {
        
    return cuckoo_manager.call("deselectRestriction(at: Int)",
            parameters: (pos),
            escapingParameters: (pos),
            superclassCall:
                
                super.deselectRestriction(at: pos)
                ,
            defaultCall: __defaultImplStub!.deselectRestriction(at: pos))
        
    }
    
    
    
     override func setCalories(min: String, max: String) throws {
        
    return try cuckoo_manager.callThrows("setCalories(min: String, max: String) throws",
            parameters: (min, max),
            escapingParameters: (min, max),
            superclassCall:
                
                super.setCalories(min: min, max: max)
                ,
            defaultCall: __defaultImplStub!.setCalories(min: min, max: max))
        
    }
    
    
    
     override func setTimes(min: String, max: String) throws {
        
    return try cuckoo_manager.callThrows("setTimes(min: String, max: String) throws",
            parameters: (min, max),
            escapingParameters: (min, max),
            superclassCall:
                
                super.setTimes(min: min, max: max)
                ,
            defaultCall: __defaultImplStub!.setTimes(min: min, max: max))
        
    }
    
    
    
     override func setUnwatedFoods(foods: String)  {
        
    return cuckoo_manager.call("setUnwatedFoods(foods: String)",
            parameters: (foods),
            escapingParameters: (foods),
            superclassCall:
                
                super.setUnwatedFoods(foods: foods)
                ,
            defaultCall: __defaultImplStub!.setUnwatedFoods(foods: foods))
        
    }
    
    
    
     override func save()  {
        
    return cuckoo_manager.call("save()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.save()
                ,
            defaultCall: __defaultImplStub!.save())
        
    }
    
    
    
     override func updateSettings()  {
        
    return cuckoo_manager.call("updateSettings()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.updateSettings()
                ,
            defaultCall: __defaultImplStub!.updateSettings())
        
    }
    
    
    
     override func logout()  {
        
    return cuckoo_manager.call("logout()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.logout()
                ,
            defaultCall: __defaultImplStub!.logout())
        
    }
    

	 struct __StubbingProxy_SettingsViewModel: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var model: Cuckoo.ClassToBeStubbedProperty<MockSettingsViewModel, SettingsModel> {
	        return .init(manager: cuckoo_manager, name: "model")
	    }
	    
	    
	    var repo: Cuckoo.ClassToBeStubbedProperty<MockSettingsViewModel, SettingsRepoProtocol> {
	        return .init(manager: cuckoo_manager, name: "repo")
	    }
	    
	    
	    var userServices: Cuckoo.ClassToBeStubbedProperty<MockSettingsViewModel, UserServicesProtocol> {
	        return .init(manager: cuckoo_manager, name: "userServices")
	    }
	    
	    
	    var userName: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "userName")
	    }
	    
	    
	    var emailAddress: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "emailAddress")
	    }
	    
	    
	    var minCalories: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "minCalories")
	    }
	    
	    
	    var maxCalories: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "maxCalories")
	    }
	    
	    
	    var minTime: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "minTime")
	    }
	    
	    
	    var maxTime: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "maxTime")
	    }
	    
	    
	    var unwantedFoods: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, String> {
	        return .init(manager: cuckoo_manager, name: "unwantedFoods")
	    }
	    
	    
	    var numRestrictions: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockSettingsViewModel, Int> {
	        return .init(manager: cuckoo_manager, name: "numRestrictions")
	    }
	    
	    
	    func setProfileData() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "setProfileData()", parameterMatchers: matchers))
	    }
	    
	    func getProfilePic<M1: Cuckoo.Matchable>(onComplete: M1) -> Cuckoo.ClassStubNoReturnFunction<((Data?) -> Void)> where M1.MatchedType == (Data?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<((Data?) -> Void)>] = [wrap(matchable: onComplete) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "getProfilePic(onComplete: @escaping (Data?) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func restrictionName<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubFunction<(Int), String> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "restrictionName(at: Int) -> String", parameterMatchers: matchers))
	    }
	    
	    func restrictionIsSelected<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubFunction<(Int), Bool> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "restrictionIsSelected(at: Int) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func selectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "selectRestriction(at: Int)", parameterMatchers: matchers))
	    }
	    
	    func deselectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.ClassStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "deselectRestriction(at: Int)", parameterMatchers: matchers))
	    }
	    
	    func setCalories<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(min: M1, max: M2) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: min) { $0.0 }, wrap(matchable: max) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "setCalories(min: String, max: String) throws", parameterMatchers: matchers))
	    }
	    
	    func setTimes<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(min: M1, max: M2) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: min) { $0.0 }, wrap(matchable: max) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "setTimes(min: String, max: String) throws", parameterMatchers: matchers))
	    }
	    
	    func setUnwatedFoods<M1: Cuckoo.Matchable>(foods: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: foods) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "setUnwatedFoods(foods: String)", parameterMatchers: matchers))
	    }
	    
	    func save() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "save()", parameterMatchers: matchers))
	    }
	    
	    func updateSettings() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "updateSettings()", parameterMatchers: matchers))
	    }
	    
	    func logout() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsViewModel.self, method: "logout()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SettingsViewModel: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var model: Cuckoo.VerifyProperty<SettingsModel> {
	        return .init(manager: cuckoo_manager, name: "model", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var repo: Cuckoo.VerifyProperty<SettingsRepoProtocol> {
	        return .init(manager: cuckoo_manager, name: "repo", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var userServices: Cuckoo.VerifyProperty<UserServicesProtocol> {
	        return .init(manager: cuckoo_manager, name: "userServices", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var userName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "userName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var emailAddress: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "emailAddress", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var minCalories: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "minCalories", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var maxCalories: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "maxCalories", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var minTime: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "minTime", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var maxTime: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "maxTime", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var unwantedFoods: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "unwantedFoods", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var numRestrictions: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "numRestrictions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func setProfileData() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setProfileData()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getProfilePic<M1: Cuckoo.Matchable>(onComplete: M1) -> Cuckoo.__DoNotUse<((Data?) -> Void), Void> where M1.MatchedType == (Data?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<((Data?) -> Void)>] = [wrap(matchable: onComplete) { $0 }]
	        return cuckoo_manager.verify("getProfilePic(onComplete: @escaping (Data?) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func restrictionName<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), String> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("restrictionName(at: Int) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func restrictionIsSelected<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), Bool> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("restrictionIsSelected(at: Int) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func selectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("selectRestriction(at: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func deselectRestriction<M1: Cuckoo.Matchable>(at pos: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pos) { $0 }]
	        return cuckoo_manager.verify("deselectRestriction(at: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setCalories<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(min: M1, max: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: min) { $0.0 }, wrap(matchable: max) { $0.1 }]
	        return cuckoo_manager.verify("setCalories(min: String, max: String) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setTimes<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(min: M1, max: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: min) { $0.0 }, wrap(matchable: max) { $0.1 }]
	        return cuckoo_manager.verify("setTimes(min: String, max: String) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setUnwatedFoods<M1: Cuckoo.Matchable>(foods: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: foods) { $0 }]
	        return cuckoo_manager.verify("setUnwatedFoods(foods: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func save() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("save()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateSettings() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("updateSettings()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func logout() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("logout()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SettingsViewModelStub: SettingsViewModel {
    
    
     override var model: SettingsModel {
        get {
            return DefaultValueRegistry.defaultValue(for: (SettingsModel).self)
        }
        
        set { }
        
    }
    
    
     override var repo: SettingsRepoProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (SettingsRepoProtocol).self)
        }
        
        set { }
        
    }
    
    
     override var userServices: UserServicesProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (UserServicesProtocol).self)
        }
        
        set { }
        
    }
    
    
     override var userName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var emailAddress: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var minCalories: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var maxCalories: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var minTime: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var maxTime: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var unwantedFoods: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     override var numRestrictions: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
     override func setProfileData()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getProfilePic(onComplete: @escaping (Data?) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func restrictionName(at pos: Int) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func restrictionIsSelected(at pos: Int) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func selectRestriction(at pos: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func deselectRestriction(at pos: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func setCalories(min: String, max: String) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func setTimes(min: String, max: String) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func setUnwatedFoods(foods: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func save()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func updateSettings()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func logout()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

