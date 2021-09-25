module Main

import Gtk3

main : IO ()
main = do
    app <- primIO $ gtk_application_new "me.dannypsnl.hello" G_Application_Flags_None
    window <- primIO $ gtk_application_window_new app
    primIO $ gtk_window_set_title window "Window"
    primIO $ gtk_window_set_default_size window 200 200
    primIO $ gtk_widget_show app
