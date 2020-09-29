#!/usr/bin/env bash

if [[ "$BUDDYBUILD_BRANCH" == "" ]]; then
    if which swiftlint >/dev/null; then
        swiftlint lint --config "${SOURCE_ROOT}"/.swiftlint.yml
        if [ $? -eq 0 ]; then
            exit
        else
            swiftlint autocorrect --config "${SOURCE_ROOT}"/.swiftlint.yml
            # after running autocorrect, lint again to see if it's fixed it, necessary to induce failure
            swiftlint lint --config "${SOURCE_ROOT}"/.swiftlint.yml
            exit
        fi
    else
        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
fi
