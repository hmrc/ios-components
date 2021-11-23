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

import Foundation
import UIKit

extension Capture {

    typealias SectionDescriptor = (type: Capture.Section, title: String, screens: [Capture.Screen])

    //swiftlint:disable:next type_body_length
    class HTMLGenerator {

        let indexFileName = "screens.html"

        let sections: [SectionDescriptor] = [
            (
                type: .organisms,
                title: "Organisms",
                screens: [
                    .headlineCardView,
                    .primaryCardView,
                    .expandingRowView,
                    .statusCardView,
                    .iconButtonCardView,
                    .summaryRowView,
                    .informationMessageCard,
                    .menuPanelRowView
                ]
            ),
            (
                type: .molecules,
                title: "Molecules",
                screens: [
                    .textInputView,
                    .currencyInputView,
                    .h4TitleBodyView,
                    .h5TitleBodyView,
                    .boldTitleBodyView,
                    .insetView,
                    .multiColumnRowView,
                    .switchRowView,
                    .iconButtonView,
                    .statusView,
                    .warningView,
                    .tabBarView,
                    .selectRowView,
                    .selectRowGroupView
                ]
            ),
            (
                type: .atoms,
                title: "Atoms",
                screens: [
                    .text,
                    .buttons
                ]
            ),
            (
                type: .colours,
                title: "Colours",
                screens: [
                    .colours
                ]
            )
        ]

        func generate() {
            guard
                let srcroot = ProcessInfo.processInfo.environment["SRCROOT"],
                let srcrootFolder = try? Folder(path: "\(srcroot)"),
                let artifactsFolder = try? srcrootFolder.createSubfolderIfNeeded(withName: "Artifacts"),
                let captureFolder = try? artifactsFolder.createSubfolderIfNeeded(withName: ScreenCapture.captureFolderName) else {
                return
            }

            deleteFileIfRequired(folder: captureFolder, fileName: indexFileName)

            let table = createTableHTML()

            outputHTMLFile(folder: captureFolder, table: table)
        }

        func createTableHTML() -> String {

            let tableHeaders: [String] = sections.map { section -> String in
                (
                    """
                    <tr>
                      <th colspan="\(section.screens.count)">
                        <a id="\(section.title)" class="appSection" href="#\(section.title)">\(section.title)</a>
                      </th>
                    </tr>
                    """)
            }

            let tableRows: [String] = sections.map { sections -> String in
                let rowCells: [String] = sections.screens.enumerated().map { (index, screen) -> String in
                    (
                        """
                        <td>
                          <p class="screenshotTitle">\(screen.rawValue.firstUppercased)</p>
                          <a href="./screens/\(screen.rawValue).png" target="_blank" class="screenshotLink">
                            <img class="screenshot" src="./screens/\(screen.rawValue).png" style="width: 100%;" data-counter="\(index)">
                          </a>
                        </td>
                        """
                    )
                }
                return "<tr>\(rowCells.reduce("", +))</tr>"
            }

            return "<table>\(tableHeaders.flatZip(tableRows).reduce("", +))</table>"
        }

        func deleteFileIfRequired(folder: Folder, fileName: String) {
            if let file = try? folder.file(named: fileName) {
                do {
                    try file.delete()
                } catch {
                    return
                }
            }
        }

        func outputHTMLFile(folder: Folder, table: String) {
            let template = htmlTemplate()

            let fontColor: String = {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return "white"
                }
                else {
                    return "#0B0C0C"
                }
            }()

            let backgroundColor: String = {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return "#262626"
                }
                else {
                    return "white"
                }
            }()

            let borderColor: String = {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return "#111"
                }
                else {
                    return "#EEE"
                }
            }()

            let substitutions = [
                "$$_TABLE_PLACEHOLDER_$$": table,
                "$$_FONT_COLOR_$$": fontColor,
                "$$_BACKGROUND_COLOR_$$": backgroundColor,
                "$$_BORDER_COLOR_$$": borderColor
            ]

            let html = substitutions
                .reduce(template) { (template, substitution) -> String in
                template.replacingOccurrences(of: substitution.key, with: substitution.value)
            }

            // swiftlint:disable:next force_try
            try! folder.createFile(named: indexFileName, contents: html)
        }

        // swiftlint:disable all
        func htmlTemplate() -> String {
            (
"""
<!DOCTYPE html>
<html>
<head>
<title>HMRC Components - Screen Captures</title>
<meta charset="UTF-8">
<style type="text/css">
* {
font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
font-weight: 300;
color: $$_FONT_COLOR_$$;
}
body {
background-color: $$_BACKGROUND_COLOR_$$;
}
.appSection {
display: block;
font-size: 30px;
padding-bottom: 24px;
padding-top: 45px;
}
.screenshot {
cursor: pointer;
border: 1px $$_BORDER_COLOR_$$ solid;
z-index: 0;
}
.screenshotTitle {
display: block;
font-size: 10px;
padding: 0;
margin: 4px;
}
th {
text-align: left;
}
td {
text-align: center;
min-width: 200px;
max-width: 250px;
vertical-align: top;
}
#overlay {
position:fixed;
top:0;
left:0;
background:rgba(0,0,0,0.8);
z-index:5;
width:100%;
height:100%;
display:none;
cursor: zoom-out;
text-align: center;
}
#imageDisplay {
height: auto;
width: auto;
z-index: 10;
cursor: pointer;
}
#imageInfo {
background: none repeat scroll 0 0 rgba(0, 0, 0, 0.2);
border-radius: 5px;
color: white;
margin: 20px;
padding: 10px;
position: absolute;
right: 0;
top: 0;
width: 250px;
z-index: -1;
}
#imageInfo:hover {
z-index: 20;
}
</style>
</head>
<body>
<h1>HMRC Components - Screen Captures</h1>
<hr>
$$_TABLE_PLACEHOLDER_$$
<div id="overlay">
<img id="imageDisplay" src="" alt="" />
<div id="imageInfo"></div>
</div>
<script type="text/javascript">
var overlay        = document.getElementById('overlay');
var imageDisplay   = document.getElementById('imageDisplay');
var imageInfo      = document.getElementById('imageInfo');
var screenshotLink = document.getElementsByClassName('screenshotLink');

function doClick(el) {
if (document.createEvent) {
var evObj = document.createEvent('MouseEvents', true);
evObj.initMouseEvent("click", false, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
el.dispatchEvent(evObj);
} else if (document.createEventObject) { //IE
var evObj = document.createEventObject();
el.fireEvent('onclick', evObj);
}
}

for (index = 0; index < screenshotLink.length; ++index) {
screenshotLink[index].addEventListener('click', function(e) {
e.preventDefault();

var img = e.target;
if (e.target.tagName == 'A') {
img = e.target.children[0];
}

// beautify
var tmpImg = new Image();
tmpImg.src = img.src;
imageDisplay.style.height     = 'auto';
imageDisplay.style.width     = 'auto';
if (window.innerHeight < tmpImg.height) {
imageDisplay.style.height = document.documentElement.clientHeight+'px';
} else if (window.innerWidth < tmpImg.width) {
imageDisplay.style.width = document.documentElement.clientWidth;+'px';
} else {
imageDisplay.style.paddingTop = parseInt((window.innerHeight - tmpImg.height) / 2)+'px';
}

imageDisplay.src             = img.src;
imageDisplay.alt             = img.alt;
imageDisplay.dataset.counter = img.dataset.counter;

imageInfo.innerHTML          = '<h3>'+img.alt+'</h3>';
imageInfo.innerHTML         += decodeURI(img.src.split("/").pop());
imageInfo.innerHTML         += '<br />'+tmpImg.height+'&times;'+tmpImg.width+'px';

overlay.style.display        = "block";
});
}

imageDisplay.addEventListener('click', function(e) {
e.stopPropagation(); // !

overlay.style.display = "none";

img_counter = parseInt(e.target.dataset.counter) + 1;
try {
link = document.body.querySelector('img[data-counter="'+img_counter+'"]').parentNode;
} catch (e) {
try {
link = document.body.querySelector('img[data-counter="0"]').parentNode;
} catch (e) {
return false;
}
}
doClick(link);
});

overlay.addEventListener('click', function(e) {
overlay.style.display = "none";
})

function keyPressed(e) {
e = e || window.event;
var charCode = e.keyCode || e.which;
switch(charCode) {
case 27: // Esc
overlay.style.display = "none";
break;
case 34: // Page Down
case 39: // Right arrow
case 54: // Keypad right
case 76: // l
case 102: // Keypad right
e.preventDefault();
doClick(imageDisplay);
break;
case 33: // Page up
case 37: // Left arrow
case 52: // Keypad left
case 72: // h
case 100: // Keypad left
e.preventDefault();
document.getElementById('imageDisplay').dataset.counter -= 2; // hacky
doClick(imageDisplay);
break;
}
};
document.body.addEventListener('keydown', keyPressed);
</script>
</body>
</html>
"""
            )
        }
        // swiftlint:enable all
    }
}

extension Sequence {
    func flatZip(_ sequence: Self) -> [Self.Element] {
        return zip(self, sequence).flatMap {[$0.0, $0.1]}
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
