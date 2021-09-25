module Gtk3

libgtk3 : String -> String
libgtk3 fn = "C:" ++ fn ++ ",libgtk-3"

export 
data App = AppWrapper AnyPtr
export
data Window = WindowWrapper AnyPtr

%foreign libgtk3 "gtk_application_new"
gtk_application_new : String -> Int -> PrimIO AnyPtr

export
application_new : HasIO io => String -> Int -> io App
application_new id flag = do
    app <- primIO $ gtk_application_new id flag
    pure $ AppWrapper app

%foreign libgtk3 "gtk_application_window_new"
gtk_application_window_new : AnyPtr -> PrimIO AnyPtr

export
application_window_new : HasIO io => App -> io Window
application_window_new (AppWrapper app) = do
    window <- primIO $ gtk_application_window_new app
    pure $ WindowWrapper window

%foreign libgtk3 "gtk_window_set_title"
gtk_window_set_title : AnyPtr -> String -> PrimIO ()

export
window_set_title : HasIO io => Window -> String -> io ()
window_set_title (WindowWrapper window) name = primIO $ gtk_window_set_title window name

%foreign libgtk3 "gtk_window_set_default_size"
gtk_window_set_default_size : AnyPtr -> Int -> Int -> PrimIO ()

export
window_set_default_size : HasIO io => Window -> Int -> Int -> io ()
window_set_default_size (WindowWrapper window) x y = primIO $ gtk_window_set_default_size window x y

%foreign libgtk3 "gtk_window_present"
gtk_window_present : AnyPtr -> PrimIO ()

export
window_present : HasIO io => Window -> io ()
window_present (WindowWrapper window) = primIO $ gtk_window_present window

%foreign libgtk3 "gtk_widget_show"
gtk_widget_show : AnyPtr -> PrimIO ()

%foreign libgtk3 "g_application_run"
g_application_run : AnyPtr -> Int -> Int -> PrimIO ()

export
run_application : HasIO io => App -> io ()
run_application (AppWrapper app) = do
    primIO $ g_application_run app 0 0

%foreign libgtk3 "g_signal_connect_object"
prim__g_signal_connect_object : AnyPtr -> String -> (callback : AnyPtr -> PrimIO ()) -> Int -> Int -> PrimIO ()

export
signal_connect : HasIO io => App -> String -> (callback : App -> IO ()) -> Int -> Int -> io ()
signal_connect (AppWrapper app) method callback o i =
    primIO $ prim__g_signal_connect_object app method (\app => toPrim $ callback (AppWrapper app)) o i

export
G_Application_Flags_None : Int
G_Application_Flags_None = 0
