/*
 * Copyright 2018 HM Revenue & Customs
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

import ObjectiveC
import UIKit

var key: UInt8 = 0

public typealias ActionBlock = (_ sender: UIButton) -> Void

class ActionBlockBox: NSObject {
    let block: ActionBlock
    init(block: @escaping ActionBlock) {
        self.block = block
    }
}

extension UIButton {
    public func componentAction(event: UIControl.Event = .touchUpInside, block: @escaping ActionBlock) {
        let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        objc_setAssociatedObject(self, &key, ActionBlockBox(block: block), policy)
        addTarget(self, action: #selector(handleComponentAction(sender:)), for: event)
    }

    @objc func handleComponentAction(sender: UIButton) {
        let box = objc_getAssociatedObject(self, &key) as? ActionBlockBox
        box?.block(sender)
    }
}
