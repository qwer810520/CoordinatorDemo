//
//  CoordinatorDemoTests.swift
//  CoordinatorDemoTests
//
//  Created by Min on 2021/12/10.
//

import XCTest
@testable import CoordinatorDemo

class CoordinatorDemoTests: XCTestCase {
    
    private struct Keys {
        static var ownerKey: UInt = 0
    }
    
    func testAssociatedObject() {
        var key = Keys()
        let value = UIViewController()
        objc_setAssociatedObject(self, &key, value, .OBJC_ASSOCIATION_ASSIGN)
        
        let sut = objc_getAssociatedObject(self, &key) as? UIViewController
        
        XCTAssertTrue(sut === value)
    }
    
    // MARK: - Private Methods
    
    
}
