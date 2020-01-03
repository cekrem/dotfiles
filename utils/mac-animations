FILE=/tmp/__ez_file_$(date +%s) 

function show_help()
{
  IT=$(CAT <<EOF

  usage: {ON|OFF}

  enables or disables animations in osx. 
  if you don't pass any arguments, it'll toggle between enabled and disabled.

  e.g. 

  ON  => All animations are enabled
  OFF => All animations are disabled
  )
  echo "$IT"
  exit
}

if [ "$1" == "help" ]
then
  show_help
fi


# returns the opposite of the current state for easy toggling
function getNewState()
{
  defaults read com.apple.dock expose-animation-duration  &> $FILE
  VAL=$(cat $FILE)
  rm $FILE
  if [ "$VAL" == "0" ]
  then
    echo "ON"
  else
    echo "OFF"
  fi
}

if [ -z "$1" ]
then
  OP=$(getNewState)
else
  OP=$1
fi

if [ "$OP" == "OFF" ]
then
  defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
  defaults write -g NSScrollAnimationEnabled -bool false
  defaults write -g NSWindowResizeTime -float 0.001
  defaults write -g QLPanelAnimationDuration -float 0
  defaults write -g NSScrollViewRubberbanding -bool false
  defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
  defaults write -g NSToolbarFullScreenAnimationDuration -float 0
  defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
  defaults write com.apple.dock autohide-time-modifier -float 0
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock expose-animation-duration -float 0
  defaults write com.apple.dock springboard-show-duration -float 0
  defaults write com.apple.dock springboard-hide-duration -float 0
  defaults write com.apple.dock springboard-page-duration -float 0
  defaults write com.apple.finder DisableAllAnimations -bool true
  defaults write com.apple.Mail DisableSendAnimations -bool true
  defaults write com.apple.Mail DisableReplyAnimations -bool true
  echo "animations disabled - reboot may be required"
  exit;
fi

if [ "$OP" == "ON" ]
then
  defaults delete -g NSAutomaticWindowAnimationsEnabled &> $FILE
  defaults delete -g NSScrollAnimationEnabled &> $FILE
  defaults delete -g NSWindowResizeTime &> $FILE
  defaults delete -g QLPanelAnimationDuration &> $FILE
  defaults delete -g NSScrollViewRubberbanding &> $FILE
  defaults delete -g NSDocumentRevisionsWindowTransformAnimation &> $FILE
  defaults delete -g NSToolbarFullScreenAnimationDuration &> $FILE
  defaults delete -g NSBrowserColumnAnimationSpeedMultiplier &> $FILE
  defaults delete com.apple.dock autohide-time-modifier &> $FILE
  defaults delete com.apple.dock autohide-delay &> $FILE
  defaults delete com.apple.dock expose-animation-duration &> $FILE
  defaults delete com.apple.dock springboard-show-duration &> $FILE
  defaults delete com.apple.dock springboard-hide-duration &> $FILE
  defaults delete com.apple.dock springboard-page-duration &> $FILE
  defaults delete com.apple.finder DisableAllAnimations &> $FILE
  defaults delete com.apple.Mail DisableSendAnimations &> $FILE
  defaults delete com.apple.Mail DisableReplyAnimations &> $FILE
  rm $FILE
  echo "animations enabled - reboot may be required"
  exit;
fi

show_help
