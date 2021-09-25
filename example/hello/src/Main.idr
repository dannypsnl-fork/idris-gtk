module Main

import Gtk3

callback : AnyPtr -> IO ()
callback app = do
    window <- primIO $ gtk_application_window_new app
    primIO $ gtk_window_set_title window "Window"
    primIO $ gtk_window_set_default_size window 200 200
    primIO $ gtk_window_present window

main : IO ()
main = do
    app <- primIO $ gtk_application_new "me.dannypsnl.hello" G_Application_Flags_None
    g_signal_connect app "activate" callback 0 0
    primIO $ g_application_run app 0 0
