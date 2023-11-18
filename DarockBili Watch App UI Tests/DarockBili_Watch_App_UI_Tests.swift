//
//  DarockBili_Watch_App_UI_Tests.swift
//  DarockBili Watch App UI Tests
//
//  Created by WindowsMEMZ on 2023/7/27.
//

import XCTest

final class DarockBili_Watch_App_UI_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppMain() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        takeScreenshot(of: app, named: "Launch")
        
        app.otherElements["MainTabView"].swipeLeft()
        sleep(1)
        app.buttons["AppSettingsButton"].firstMatch.tap()
        
        takeScreenshot(of: app, named: "PC")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCTestCase {
    /// Take a screenshot of a given app and add it to the test attachements.
    /// - Parameters:
    ///   - app: The app to take a screenshot of.
    ///   - name: The name of the screenshot.
    func takeScreenshot(of app: XCUIApplication, named name: String) {
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        #if os(iOS)
        let name = "Screenshot-\(name)-\(UIDevice.current.name).png"
        #else
        let name = "Screenshot-\(name)-watchOS.png"
        #endif
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)

        let url = downloadsFolder.appendingPathComponent("appshot.png")
        try! appshot.pngRepresentation.write(to: url)
    }
}

var downloadsFolder: URL = {
    let fm = FileManager.default
    let folder = fm.urls(for: .downloadsDirectory, in: .userDomainMask)[0]

    var isDirectory: ObjCBool = false
    if !(fm.fileExists(atPath: folder.path, isDirectory: &isDirectory) && isDirectory.boolValue) {
        try! fm.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
    }
    return folder
}()
