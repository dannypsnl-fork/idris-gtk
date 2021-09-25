module Main

import Gtk3

callback : App -> IO ()
callback app = do
    window <- application_window_new app
    window_set_title window "Window"
    window_set_default_size window 200 200

    label <- new_label "Hello World"
    set_parent label window

    btn <- new_button "Click me"
    set_parent btn window

    window_present window

main : IO ()
main = do
    app <- application_new "me.dannypsnl.hello" G_Application_Flags_None
    signal_connect app "activate" callback
    run_application app
