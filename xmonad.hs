import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  barProc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad defaultConfig {
    logHook = dynamicLogWithPP xmobarPP {
      ppOutput = hPutStrLn barProc,
      ppTitle = xmobarColor "green" "" . shorten 50
    },
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts $ layoutHook defaultConfig,
    borderWidth = 2, normalBorderColor = "cccccc",
    modMask = mod4Mask
}