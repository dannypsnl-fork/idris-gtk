module Main

import Gtk3

main : IO ()
main = do
    app <- primIO $ gtk_application_new "hello" 0
    primIO $ gtk_window_set_title app "Window"
    primIO $ gtk_window_set_default_size app 200 200
    primIO $ gtk_widget_show app
