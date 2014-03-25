import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Prompt
import XMonad.Prompt.AppendFile
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

main = do
  barProc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ myConfig {
    logHook = dynamicLogWithPP xmobarPP {
      ppOutput = hPutStrLn barProc,
      ppTitle = xmobarColor "green" "" . shorten 50
    }
  } `additionalKeysP` [("M-n", addReminder)]

addReminder :: X ()
addReminder = appendFilePrompt defaultXPConfig "/home/alyssa/.xmonad/reminders"

myConfig = defaultConfig {
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts $ layoutHook defaultConfig,
    borderWidth = 2, normalBorderColor = "cccccc",
    modMask = mod4Mask,
    terminal = "urxvt"
  }