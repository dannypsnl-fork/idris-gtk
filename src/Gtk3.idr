module Gtk3

import public Gtk3.Const

libgtk3 : String -> String
libgtk3 fn = "C:" ++ fn ++ ",libgtk-3"

export 
data App = AppWrapper AnyPtr

public export
data Orientation = Horizontal | Vertical

interface Widget a where
    get : a -> AnyPtr

export
data Window = WindowWrapper AnyPtr
export
Widget Window where get (WindowWrapper a) = a
export 
data Label = LabelWrapper AnyPtr
export
Widget Label where get (LabelWrapper a) = a
export 
data Button = ButtonWrapper AnyPtr
export
Widget Button where get (ButtonWrapper a) = a
export
data Paned = PanedWrapper AnyPtr
export
Widget Paned where get (PanedWrapper a) = a

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

%foreign libgtk3 "g_application_run"
g_application_run : AnyPtr -> Int -> Int -> PrimIO ()
export
run_application : HasIO io => App -> io ()
run_application (AppWrapper app) = do
    primIO $ g_application_run app 0 0

%foreign libgtk3 "g_signal_connect_object"
prim__g_signal_connect_object : AnyPtr -> String -> (callback : AnyPtr -> PrimIO ()) -> Int -> Int -> PrimIO ()
export
signal_connect : HasIO io => App -> String -> (callback : App -> IO ()) -> io ()
signal_connect (AppWrapper app) method callback =
    primIO $ prim__g_signal_connect_object app method (\app => toPrim $ callback (AppWrapper app)) 0 0

%foreign libgtk3 "gtk_widget_set_parent"
gtk_widget_set_parent : AnyPtr -> AnyPtr -> PrimIO ()
export
set_parent : Widget a => Widget parent => a -> parent -> IO ()
set_parent a parent = primIO $ gtk_widget_set_parent (get a) (get parent)

%foreign libgtk3 "gtk_paned_new"
gtk_paned_new : Int -> PrimIO AnyPtr
export
new_paned : HasIO io => Orientation -> io Paned
new_paned Horizontal = do
    p <- primIO $ gtk_paned_new 0
    pure $ PanedWrapper p
new_paned Vertical = do
    p <- primIO $ gtk_paned_new 1
    pure $ PanedWrapper p

%foreign libgtk3 "gtk_container_add"
gtk_container_add : AnyPtr -> AnyPtr -> PrimIO ()
export
paned_add : HasIO io => Widget a => Paned -> a -> io ()
paned_add (PanedWrapper p) widget = primIO $ gtk_container_add p (get widget)

%foreign libgtk3 "gtk_label_new"
gtk_label_new : String -> PrimIO AnyPtr
export
new_label : HasIO io => String -> io Label
new_label label = do
    label <- primIO $ gtk_label_new label
    pure $ LabelWrapper label

%foreign libgtk3 "gtk_button_new_with_label"
gtk_button_new_with_label : String -> PrimIO AnyPtr
export
new_button : HasIO io => String -> io Button
new_button label = do
    btn <- primIO $ gtk_button_new_with_label label
    pure $ ButtonWrapper btn
