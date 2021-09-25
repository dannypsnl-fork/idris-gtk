module Gtk

libgtk4 : String -> String
libgtk4 fn = "C:" ++ fn ++ ",libgtk-3"

%foreign libgtk4 "gtk_application_new"
export gtk_application_new : String -> Int -> PrimIO AnyPtr

%foreign libgtk4 "gtk_window_set_title"
export gtk_window_set_title : AnyPtr -> String -> PrimIO ()

%foreign libgtk4 "gtk_window_set_default_size"
export gtk_window_set_default_size : AnyPtr -> Int -> Int -> PrimIO ()

%foreign libgtk4 "gtk_widget_show"
export gtk_widget_show : AnyPtr -> PrimIO ()
