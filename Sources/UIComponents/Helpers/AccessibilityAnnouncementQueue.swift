/*
 * Copyright 2021 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

class AccessibilityAnnouncementQueue {

    static let shared = AccessibilityAnnouncementQueue()

    private var queue: [String] = []

    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(announcementFinished(_:)),
            name: UIAccessibility.announcementDidFinishNotification,
            object: nil)
    }

    func post(announcement: String) {
        guard UIAccessibility.isVoiceOverRunning else { return }

        queue.append(announcement)
        postNotification(announcement)
    }


    private func postNotification(_ message: String) {
        let attrMessage: NSAttributedString = .init(
            string: message,
            attributes: [.accessibilitySpeechQueueAnnouncement: true]
        )
        UIAccessibility.post(notification: .announcement, argument: attrMessage)
    }

    @objc private func announcementFinished(_ sender: Notification) {
        guard
            let userInfo = sender.userInfo,
            let firstQueueItem = queue.first,
            let announcement = userInfo[UIAccessibility.announcementStringValueUserInfoKey] as? String,
            let success = userInfo[UIAccessibility.announcementWasSuccessfulUserInfoKey] as? Bool,
            firstQueueItem == announcement
        else { return }

        if success {
            queue.removeFirst()
        } else {
            postNotification(firstQueueItem)
        }
    }
}
