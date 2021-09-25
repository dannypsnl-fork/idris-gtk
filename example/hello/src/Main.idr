module Main

import Gtk3

callback : App -> IO ()
callback app = do
    window <- application_window_new app
    window_set_title window "Window"
    window_set_default_size window 200 200
    window_present window

main : IO ()
main = do
    app <- application_new "me.dannypsnl.hello" G_Application_Flags_None
    g_signal_connect app "activate" callback 0 0
    run_application app
