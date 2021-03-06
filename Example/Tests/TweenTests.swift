//
//  TweenTests.swift
//  Kinetic
//
//  Created by Nicholas Shipes on 7/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import Kinetic

class TweenTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testManualProgressUpdateTriggersCallbacks() {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0))
		
		var updateTriggered = false
		var completeTriggered = false
		
        let tween = Tween(target: view).to(Size(100.0, 100.0)).duration(2.0)
		tween.on(.updated) { (tween) in
			updateTriggered = true
		}.on(.completed) { (tween) in
			completeTriggered = true
		}
		
		expect(tween.duration).to(equal(2.0))
		expect(tween.time).to(equal(0))
		
		tween.progress = 0.5
		expect(tween.time).to(equal(1.0))
		expect(updateTriggered).to(beTrue())
		expect(view.frame.size).to(equal(CGSize(width: 75.0, height: 75.0)))
		
		tween.progress = 1.0
		expect(view.frame.size).to(equal(CGSize(width: 100.0, height: 100.0)))
		expect(completeTriggered).to(beTrue())
    }
	
	func testCustomEasingCurve() {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0))
		
		var completeTriggered = false
		
		let tween = Tween(target: view).to(Size(100.0, 100.0)).duration(2.0)
		tween.ease(Bezier(0.24, 1.24, 0.43, 1.01))
		tween.on(.updated) { (tween) in
			print(view.frame.size)
		}
		tween.on(.completed) { (tween) in
			completeTriggered = true
		}
		tween.play()
		
		expect(completeTriggered).toEventually(beTrue(), timeout: 2.5)
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
