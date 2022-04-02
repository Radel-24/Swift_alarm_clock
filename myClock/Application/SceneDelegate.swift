//
//  SceneDelegate.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        registerLocal()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: StartController())
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    private func removeClocksInPast() {
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
        for clock in clocks {
            for date in clock.ringDays {
                if (date < today){
                    let indexClock = clocks.firstIndex(where: {$0.id == clock.id})
                    let indexDate = clocks[indexClock!].ringDays.firstIndex(where: {$0 == date})
                    clocks[indexClock!].ringDays.remove(at: indexDate!)
                }
            }
        }
        writeToFile(location: subUrl!)
    }

    private func setNextClocks() {
        for clock in clocks {
            if (clock.isActivated) {
                scheduleClock(clockId: clock.id)
            } else {
//                unscheduleClock(clockId: clock.id)
            }
        }
        writeToFile(location: subUrl!)
    }
    
    private func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]){(granted, error) in
            if granted {
                print("User notifications were granted")
            } else {
                print("User notifications not granted")
            }
        }
    }
    
//    private func unscheduleClock(clockId: UUID) {
//        let center = UNUserNotificationCenter.current()
//        let clockIndex = clocks.firstIndex(where: {$0.id == clockId})
//
//        center.removePendingNotificationRequests(withIdentifiers: [clocks[clockIndex!].notificationId])
//    }
    
    private func unscheduleAllClocks() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    private func findNextRingDate(ringDates: [DateComponents]) -> DateComponents {
        
        var nextDate = ringDates[0]
        for date in ringDates {
            if (date < nextDate) {
                nextDate = date
            }
        }
        print("next date \(nextDate)")

        return nextDate
    }
    
    private func scheduleClock(clockId: UUID) {
        
        let clockIndex = clocks.firstIndex(where: {$0.id == clockId})
        let clock = clocks[clockIndex!]
        
        let center = UNUserNotificationCenter.current()
        
//        center.removeDeliveredNotifications(withIdentifiers: [clock.notificationId])
//        center.removePendingNotificationRequests(withIdentifiers: [clock.notificationId])
        if (clock.ringDays.isEmpty) { return }
        let nextDate = findNextRingDate(ringDates: clock.ringDays)
        // TODO find next ring date an put it to ring date
        let ringDate = DateComponents(calendar: Calendar.current, year: nextDate.year, month: nextDate.month, day: nextDate.day, hour: clock.ringTime.hour, minute: clock.ringTime.minute)
        print(ringDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: ringDate, repeats: false)

        let content = UNMutableNotificationContent()
        content.title = clock.name
        content.body = "get up now you lazy bastard!!!"
        content.categoryIdentifier = "myIdentifier"
        content.userInfo = ["Id": 7]
        content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName(rawValue: "tickle.mp3"))

        
        
        clocks[clockIndex!].notificationId = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: clock.notificationId, content: content, trigger: trigger)
        center.add(request)
//        for index in 1...10 {
//            UIScreen.main.brightness = CGFloat(Double(index) * 0.1)
//            print(Double(index) * 0.1)
//            sleep(1)
//        }
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        removeClocksInPast()
        unscheduleAllClocks()
        setNextClocks()
        
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

