module Main

import Gtk3

callback : App -> IO ()
callback app = do
    window <- application_window_new app
    window_set_title window "Window"
    window_set_default_size window 200 200

    pane <- new_paned Horizontal
    set_parent pane window

    label <- new_label "Hello World"
    paned_add pane label

    btn <- new_button "Click me"
    paned_add pane btn

    window_present window

main : IO ()
main = do
    app <- application_new "me.dannypsnl.hello" G_Application_Flags_None
    signal_connect app "activate" callback
    run_application app
