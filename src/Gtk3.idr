module Gtk3

libgtk3 : String -> String
libgtk3 fn = "C:" ++ fn ++ ",libgtk-3"

%foreign libgtk3 "gtk_application_new"
export gtk_application_new : String -> Int -> PrimIO AnyPtr

%foreign libgtk3 "gtk_window_set_title"
export gtk_window_set_title : AnyPtr -> String -> PrimIO ()

%foreign libgtk3 "gtk_window_set_default_size"
export gtk_window_set_default_size : AnyPtr -> Int -> Int -> PrimIO ()

%foreign libgtk3 "gtk_widget_show"
export gtk_widget_show : AnyPtr -> PrimIO ()
