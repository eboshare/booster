#!/bin/bash

readonly INTL_UTILS_PACKAGE="intl_utils"
readonly PACKAGE_LIST=$(flutter pub global list)
readonly GREP_OUTPUT=$(echo "$PACKAGE_LIST" | grep "$INTL_UTILS_PACKAGE")

if [ "$GREP_OUTPUT" == "" ]; then
  echo "Activation of $INTL_UTILS_PACKAGE"
  flutter pub global activate "$INTL_UTILS_PACKAGE"
fi

echo "Generating localizations"
flutter pub global run intl_utils:generate
echo "Localizations generated"
