echo "Checking for requirements:"

if [ -d "/Applications/Xcode.app/Contents/Developer" ]; then
  XCODE_FOUND=true
  echo "\t✓ Found Xcode.app."
else
  echo "\t✗ Missing Xcode.app. Install it from the App Store."
  echo "In Terminal? Command + Double click to open Xcode.app in the Mac App Store."
  echo "http://appstore.com/mac/xcode"
  exit 1
fi

if [ -d "/usr/local/Cellar" ]; then
  HOMEBREW_FOUND=true
  echo "\t✓ Found Homebrew.app."
else
  echo "\t✗ Missing Homebrew."
  echo "In Terminal? Command + Double click to go to the official Homebrew site."
  echo "http://brew.sh/"
  exit 1
fi

echo

if [ "$XCODE_FOUND" = true -a "$HOMEBREW_FOUND" = true ]; then
  echo "Proceeding to install things!"
  echo "Please don't touch! :)"
else
  echo "Missing requirements. Please look at the above requirements and retry when fulfilled."
  exit 1
fi

echo

if [ "$CASK" = false ]; then
  echo "\tCASK is equal to false. Skipping homebrew-cask..."
  break 1
else
  if [ ! -f "/usr/local/bin/brew-cask.rb" ]; then
    echo "\tTapping homebrew-cask..."
    brew tap 'phinze/cask' >> /dev/null 2>&1
    if [ -f "/usr/local/bin/brew-cask.rb" ]; then
      echo "\thomebrew-cask install successful!"
    else
      echo "\thomebrew-cask install failed."
      echo "\tPlease try and install manually: "
      echo "\t\"brew tap 'phinze/cask'\""
    fi
  else
    echo "\thomebrew-cask already installed."
  fi

  if [ -f "casks" ]; then
    while read line
    do
      brew cask install "$line"
    done <casks
  else
    echo "\tMissing list in 'cask' file."
    break 1
  fi
fi

if [ "$BREWS" = false ]; then
  echo "\tBREWS is equal to false. Skipping brews..."
  break 1
else
  echo "\tInstalling brews"
  if [ -f "brews" ]; then
    while read line
    do
      brew install "$line"
    done <brews
  else
    echo "\tMissing list in 'brews' file."
    break 1
  fi
fi

echo "❤ Installation completed.❤"
