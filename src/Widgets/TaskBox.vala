namespace Timetable {
    public class TaskBox : Gtk.ListBoxRow {
        private MainWindow win;
        private int uid;
        private static int uid_counter;

        public TaskPreferences popover;
        public TaskEventBox evbox;
        public Gtk.Label task_label;
        public Gtk.Label task_time_from_label;
        public Gtk.Label task_time_sep_label;
        public Gtk.Label task_time_to_label;
        public string task_name;
        public string color;
        public string tcolor;
        public string time_to_text;
        public string time_from_text;
        public bool task_allday;

        private const Gtk.TargetEntry[] targetEntries = {
            {"TASKBOX", Gtk.TargetFlags.SAME_APP, 0}
        };

        public TaskBox (MainWindow win, string task_name, string color, string time_from_text, string time_to_text, bool task_allday) {
            var settings = AppSettings.get_default ();
            this.win = win;
            this.uid = uid_counter++;
            this.task_name = task_name;
            this.color = color;
            this.tcolor = color;
            this.time_to_text = time_to_text;
            this.time_from_text = time_from_text;
            this.task_allday = task_allday;

            change_theme ();
            update_theme ();
            win.tm.save_notes ();
            build_drag_and_drop ();

            settings.changed.connect (() => {
                change_theme ();
                update_theme ();
                win.tm.save_notes ();
            });

            evbox = new TaskEventBox (this, task_name, time_from_text, time_to_text, task_allday);

            var task_grid = new Gtk.Grid ();
            task_grid.hexpand = false;
            task_grid.row_spacing = 6;
            task_grid.row_homogeneous = true;
            task_grid.margin_top = task_grid.margin_bottom = 12;
            task_grid.margin_start = task_grid.margin_end = 12;
            task_grid.attach (evbox, 0, 0, 1, 2);

            evbox.settings_requested.connect (() => {
                popover = new TaskPreferences (win, this);
            });

            evbox.delete_requested.connect (() => {
                this.destroy ();
                win.tm.save_notes ();
            });

            this.add (task_grid);
            this.hexpand = false;
            this.show_all ();
        }

        public void update_theme () {
            var css_provider = new Gtk.CssProvider();
            this.get_style_context ().add_class ("tt-box-%d".printf(uid));
            var settings = AppSettings.get_default ();
            string style = null;
            string tcolor = null;
            if (settings.theme == 0) {
                // Coming from Flat
                if (color == "#F33B61") {
                    tcolor = "#ed5353";
                }
                if (color == "#ffa358") {
                    tcolor = "#ffa154";
                }
                if (color == "#FFE379") {
                    tcolor = "#ffe16b";
                }
                if (color == "#9CCF81") {
                    tcolor = "#9bdb4d";
                }
                if (color == "#8ED0FF") {
                    tcolor = "#64baff";
                }
                if (color == "#C1AFF2") {
                    tcolor = "#ad65d6";
                }
                // Coming from Nature
                if (color == "#ff5656") {
                    tcolor = "#ed5353";
                }
                if (color == "#fa983a") {
                    tcolor = "#ffa154";
                }
                if (color == "#f6d95b") {
                    tcolor = "#ffe16b";
                }
                if (color == "#78e08f") {
                    tcolor = "#9bdb4d";
                }
                if (color == "#82ccdd") {
                    tcolor = "#64baff";
                }
                if (color == "#ad65d6") {
                    tcolor = "#ad65d6";
                }
                // Going to elementary
                if (color == "#ed5353") {
                    tcolor = "#ed5353";
                }
                if (color == "#ffa154") {
                    tcolor = "#ffa154";
                }
                if (color == "#ffe16b") {
                    tcolor = "#ffe16b";
                }
                if (color == "#9bdb4d") {
                    tcolor = "#9bdb4d";
                }
                if (color == "#64baff") {
                    tcolor = "#64baff";
                }
                if (color == "#ad65d6") {
                    tcolor = "#ad65d6";
                }
                // Resetted color
                if (color == "#d4d4d4") {
                    tcolor = "#d4d4d4";
                }
            } else if (settings.theme == 1) {
                // Coming from elementary
                if (color == "#ed5353") {
                    tcolor = "#F33B61";
                }
                if (color == "#ffa154") {
                    tcolor = "#ffa358";
                }
                if (color == "#ffe16b") {
                    tcolor = "#FFE379";
                }
                if (color == "#9bdb4d") {
                    tcolor = "#9CCF81";
                }
                if (color == "#64baff") {
                    tcolor = "#8ED0FF";
                }
                if (color == "#ad65d6") {
                    tcolor = "#C1AFF2";
                }
                // Coming from Nature
                if (color == "#ff5656") {
                    tcolor = "#F33B61";
                }
                if (color == "#fa983a") {
                    tcolor = "#ffa358";
                }
                if (color == "#f6d95b") {
                    tcolor = "#FFE379";
                }
                if (color == "#78e08f") {
                    tcolor = "#9CCF81";
                }
                if (color == "#82ccdd") {
                    tcolor = "#8ED0FF";
                }
                if (color == "#8498e6") {
                    tcolor = "#C1AFF2";
                }
                // Going to Flat
                if (color == "#F33B61") {
                    tcolor = "#F33B61";
                }
                if (color == "#ffa358") {
                    tcolor = "#ffa358";
                }
                if (color == "#FFE379") {
                    tcolor = "#FFE379";
                }
                if (color == "#9CCF81") {
                    tcolor = "#9CCF81";
                }
                if (color == "#8ED0FF") {
                    tcolor = "#8ED0FF";
                }
                if (color == "#C1AFF2") {
                    tcolor = "#C1AFF2";
                }
                // Resetted color
                if (color == "#d4d4d4") {
                    tcolor = "#d4d4d4";
                }
            } else if (settings.theme == 2) {
                // Coming from elementary
                if (color == "#ed5353") {
                    tcolor = "#ff5656";
                }
                if (color == "#ffa154") {
                    tcolor = "#fa983a";
                }
                if (color == "#ffe16b") {
                    tcolor = "#f6d95b";
                }
                if (color == "#9bdb4d") {
                    tcolor = "#78e08f";
                }
                if (color == "#64baff") {
                    tcolor = "#82ccdd";
                }
                if (color == "#ad65d6") {
                    tcolor = "#8498e6";
                }
                // Coming from Flat
                if (color == "#F33B61") {
                    tcolor = "#ff5656";
                }
                if (color == "#ffa358") {
                    tcolor = "#fa983a";
                }
                if (color == "#FFE379") {
                    tcolor = "#f6d95b";
                }
                if (color == "#9CCF81") {
                    tcolor = "#78e08f";
                }
                if (color == "#8ED0FF") {
                    tcolor = "#82ccdd";
                }
                if (color == "#C1AFF2") {
                    tcolor = "#8498e6";
                }
                // Going to Nature
                if (color == "#ff5656") {
                    tcolor = "#ff5656";
                }
                if (color == "#fa983a") {
                    tcolor = "#fa983a";
                }
                if (color == "#f6d95b") {
                    tcolor = "#f6d95b";
                }
                if (color == "#78e08f") {
                    tcolor = "#78e08f";
                }
                if (color == "#82ccdd") {
                    tcolor = "#82ccdd";
                }
                if (color == "#8498e6") {
                    tcolor = "#8498e6";
                }
                // Resetted color
                if (color == "#d4d4d4") {
                    tcolor = "#d4d4d4";
                }
            }
            if (settings.high_contrast) {
                if (settings.show_tasks_allday && this.task_allday) {
                    style = ("""
                        .tt-box-%d {
                            border-top: none;
                            border-right: none;
                            border-bottom: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: none;
                            background-color: shade (%s, 0.5);
                            color: #FFFFFF;
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.33), 0.12),
                                0 1px 2px alpha (shade (%s, 0.33), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d:selected.activatable {
                            color: #FFF;
                        }
                        .tt-box-%d:selected.activatable:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d image {
                            color: #FFFFFF;
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: #666;
                        }
                    """).printf(uid, tcolor, tcolor, tcolor, uid, uid, uid, uid, uid);
                } else {
                    style = ("""
                        .tt-box-%d {
                            border-top: none;
                            border-right: none;
                            border-bottom: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: 3px solid shade (%s, 0.5);
                            background-color: shade (%s, 0.5);
                            color: #FFF;
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.33), 0.12),
                                0 1px 2px alpha (shade (%s, 0.33), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d:selected.activatable {
                            color: #FFF;
                        }
                        .tt-box-%d:selected.activatable:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d image {
                            color: #FFFFFF;
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: #666;
                        }
                    """).printf(uid, tcolor, tcolor, tcolor, tcolor, uid, uid, uid, uid, uid);
                }
            } else {
                if (settings.show_tasks_allday && this.task_allday) {
                    style = ("""
                        .tt-box-%d {
                            border-bottom: none;
                            border-top: none;
                            border-right: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: 3px solid mix (%s, #FFF, 0.5);
                            background-color: mix (%s, #FFF, 0.5);
                            color: shade (%s, 0.4);
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.33), 0.12),
                                0 1px 2px alpha (shade (%s, 0.33), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: shade (%s, 0.6);
                        }
                        .tt-box-%d:selected.activatable {
                            color: shade (%s, 0.4);
                        }
                        .tt-box-%d:selected.activatable:backdrop {
                            color: shade (%s, 0.6);
                        }
                        .tt-box-%d image {
                            color: shade (%s, 0.4);
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: shade (%s, 0.6);
                        }
                    """).printf(uid, tcolor, tcolor, tcolor, tcolor, tcolor, uid, tcolor, uid, tcolor, uid, tcolor, uid, tcolor, uid, tcolor);
                } else {
                    style = ("""
                        .tt-box-%d {
                            border-bottom: none;
                            border-top: none;
                            border-right: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: 3px solid %s;
                            background-color: mix (%s, #FFF, 0.7);
                            color: shade (%s, 0.5);
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.5), 0.12),
                                0 1px 2px alpha (shade (%s, 0.5), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: shade (%s, 0.88);
                        }
                        .tt-box-%d:selected.activatable {
                            color: shade (%s, 0.5);
                        }
                        .tt-box-%d:selected.activatable:backdrop {
                            color: shade (%s, 0.88);
                        }
                        .tt-box-%d image {
                            color: shade (%s, 0.5);
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: shade (%s, 0.88);
                        }
                    """).printf(uid, tcolor, tcolor, tcolor, tcolor, tcolor, uid, tcolor, uid, tcolor, uid, tcolor, uid, tcolor, uid, tcolor);
                }
            }
            try {
                css_provider.load_from_data(style, -1);
            } catch (GLib.Error e) {
                warning ("Failed to parse css style : %s", e.message);
            }

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

        private void change_theme () {
            var settings = AppSettings.get_default ();
            if (settings.theme == 0) {
                var provider = new Gtk.CssProvider ();
                provider.load_from_resource ("/com/github/lainsce/timetable/elementary.css");
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } else if (settings.theme == 1) {
                var provider = new Gtk.CssProvider ();
                provider.load_from_resource ("/com/github/lainsce/timetable/flat.css");
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } else if (settings.theme == 2) {
                var provider = new Gtk.CssProvider ();
                provider.load_from_resource ("/com/github/lainsce/timetable/nature.css");
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            }
        }
    
        private void build_drag_and_drop () {
            Gtk.drag_source_set (this, Gdk.ModifierType.BUTTON1_MASK, targetEntries, Gdk.DragAction.MOVE);
    
            drag_begin.connect (on_drag_begin);
            drag_data_get.connect (on_drag_data_get);
        }
    
        private void on_drag_begin (Gtk.Widget widget, Gdk.DragContext context) {
            var row = (TaskBox) widget;
            Gtk.Allocation alloc;
            row.get_allocation (out alloc);
    
            var surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, alloc.width, alloc.height);
            var cr = new Cairo.Context (surface);

            cr.set_source_rgba (255, 255, 255, 1);
            cr.rectangle (0, 0, alloc.width, alloc.height-15);
            cr.fill ();
    
            row.draw (cr);
    
            Gtk.drag_set_icon_surface (context, surface);
        }
    
        private void on_drag_data_get (Gtk.Widget widget, Gdk.DragContext context, Gtk.SelectionData selection_data, uint target_type, uint time) {
            uchar[] data = new uchar[(sizeof (TaskBox))];
            ((Gtk.Widget[])data)[0] = widget;
    
            selection_data.set (
                Gdk.Atom.intern_static_string ("TASKBOX"), 32, data
            );
        }  
    }
}