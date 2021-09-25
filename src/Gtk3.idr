module Gtk3

libgtk3 : String -> String
libgtk3 fn = "C:" ++ fn ++ ",libgtk-3"

%foreign libgtk3 "gtk_application_new"
export gtk_application_new : String -> Int -> PrimIO AnyPtr

%foreign libgtk3 "gtk_application_window_new"
export gtk_application_window_new : AnyPtr -> PrimIO AnyPtr

%foreign libgtk3 "gtk_window_set_title"
export gtk_window_set_title : AnyPtr -> String -> PrimIO ()

%foreign libgtk3 "gtk_window_set_default_size"
export gtk_window_set_default_size : AnyPtr -> Int -> Int -> PrimIO ()

%foreign libgtk3 "gtk_window_present"
export gtk_window_present : AnyPtr -> PrimIO ()

%foreign libgtk3 "gtk_widget_show"
export gtk_widget_show : AnyPtr -> PrimIO ()

%foreign libgtk3 "g_application_run"
export g_application_run : AnyPtr -> Int -> Int -> PrimIO ()

%foreign libgtk3 "g_signal_connect_object"
prim__g_signal_connect_object : AnyPtr -> String -> (callback : AnyPtr -> PrimIO ()) -> Int -> Int -> PrimIO ()

export
g_signal_connect : AnyPtr -> String -> (callback : AnyPtr -> IO ()) -> Int -> Int -> IO ()
g_signal_connect app method callback o i = primIO $ prim__g_signal_connect_object app method (\app=>toPrim $ callback app) o i

export
G_Application_Flags_None : Int
G_Application_Flags_None = 0
