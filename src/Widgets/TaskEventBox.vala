namespace Timetable {
    public class TaskEventBox : Gtk.EventBox {
        public TaskBox tb;
        public Gtk.Button app_button;
        public Gtk.Button task_delete_button;
        public Gtk.Revealer revealer;

        public bool show_button = true;
        public bool show_popover = true;
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

        public signal void settings_requested ();
        public signal void delete_requested ();

        public TaskEventBox (TaskBox tb, string task_name, string time_from_text, string time_to_text, bool task_allday) {
            this.tb = tb;
            this.task_name = task_name;
            this.tcolor = color;
            this.time_to_text = time_to_text;
            this.time_from_text = time_from_text;
            this.task_allday = task_allday;

            task_label = new Gtk.Label ("");
            task_label.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            task_label.halign = Gtk.Align.START;
            task_label.wrap = true;
            task_label.hexpand = true;
            task_label.label = this.task_name;

            task_time_from_label = new Gtk.Label ("");
            task_time_from_label.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            task_time_from_label.halign = Gtk.Align.START;
            task_time_from_label.label = this.time_from_text;

            task_time_to_label = new Gtk.Label ("");
            task_time_to_label.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            task_time_to_label.halign = Gtk.Align.START;
            task_time_to_label.label = this.time_to_text;

            if (this.task_allday) {
                task_time_sep_label = new Gtk.Label ("");
                task_time_sep_label.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                                              Gdk.EventMask.LEAVE_NOTIFY_MASK &
                                              Gdk.EventMask.BUTTON_PRESS_MASK &
                                              Gdk.EventMask.BUTTON_RELEASE_MASK;
            } else {
                task_time_sep_label = new Gtk.Label ("-");
                task_time_sep_label.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                                              Gdk.EventMask.LEAVE_NOTIFY_MASK &
                                              Gdk.EventMask.BUTTON_PRESS_MASK &
                                              Gdk.EventMask.BUTTON_RELEASE_MASK;
            }

            var date_time_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            date_time_box.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            date_time_box.pack_start (task_time_from_label, false, true, 0);
            date_time_box.pack_start (task_time_sep_label, false, true, 0);
            date_time_box.pack_start (task_time_to_label, false, true, 0);

            var task_box = new Gtk.Grid ();
            task_box.row_homogeneous = true;
            task_box.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            task_box.attach (task_label, 0, 0);
            task_box.attach (date_time_box, 0, 1);

            task_delete_button = new Gtk.Button();
            task_delete_button.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                                         Gdk.EventMask.LEAVE_NOTIFY_MASK &
                                         Gdk.EventMask.BUTTON_PRESS_MASK &
                                         Gdk.EventMask.BUTTON_RELEASE_MASK;
            var task_delete_button_c = task_delete_button.get_style_context ();
            task_delete_button_c.add_class ("flat");
            task_delete_button_c.add_class ("icon-shadow");
            task_delete_button.has_tooltip = true;
            task_delete_button.vexpand = false;
            task_delete_button.valign = Gtk.Align.CENTER;
            task_delete_button.set_image (new Gtk.Image.from_icon_name (
                                             "edit-delete-symbolic",
                                             Gtk.IconSize.SMALL_TOOLBAR
                                          ));
            task_delete_button.tooltip_text = (_("Delete Task"));

            app_button = new Gtk.Button();
            app_button.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                                 Gdk.EventMask.LEAVE_NOTIFY_MASK &
                                 Gdk.EventMask.BUTTON_PRESS_MASK &
                                 Gdk.EventMask.BUTTON_RELEASE_MASK;
            var app_button_context = app_button.get_style_context ();
            app_button_context.add_class ("flat");
            app_button_context.add_class ("icon-shadow");
            app_button.has_tooltip = true;
            app_button.vexpand = false;
            app_button.valign = Gtk.Align.CENTER;
            app_button.tooltip_text = (_("Task Settings"));
            app_button.image = new Gtk.Image.from_icon_name (
                                    "open-menu-symbolic",
                                    Gtk.IconSize.SMALL_TOOLBAR
                               );

            var task_buttons_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
            task_buttons_box.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                                       Gdk.EventMask.LEAVE_NOTIFY_MASK &
                                       Gdk.EventMask.BUTTON_PRESS_MASK &
                                       Gdk.EventMask.BUTTON_RELEASE_MASK;
            task_buttons_box.pack_start (app_button, false, true, 0);
            task_buttons_box.pack_start (task_delete_button, false, true, 0);

            revealer = new Gtk.Revealer ();
            revealer.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            revealer.set_transition_duration (100);
            revealer.set_transition_type (Gtk.RevealerTransitionType.CROSSFADE);
            revealer.halign = Gtk.Align.START;
            revealer.add (task_buttons_box);

            var grid = new Gtk.Grid ();
            grid.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                               Gdk.EventMask.LEAVE_NOTIFY_MASK &
                               Gdk.EventMask.BUTTON_PRESS_MASK &
                               Gdk.EventMask.BUTTON_RELEASE_MASK;
            grid.attach (task_box, 0, 0);
            grid.attach (revealer, 1, 0);

            this.add (grid);
            this.events |= Gdk.EventMask.ENTER_NOTIFY_MASK &
                           Gdk.EventMask.LEAVE_NOTIFY_MASK &
                           Gdk.EventMask.BUTTON_PRESS_MASK &
                           Gdk.EventMask.BUTTON_RELEASE_MASK;

            task_delete_button.clicked.connect (() => {
                delete_requested ();
            });

            app_button.clicked.connect(() => {
                settings_requested ();
            });

            this.enter_notify_event.connect ((event) => {
                revealer.set_reveal_child (this.show_button);
                return false;
            });

            this.leave_notify_event.connect ((event) => {
                if (tb.popover != null && tb.popover.get_visible () == true) {
    	            return true;
    	        }
    	        revealer.set_reveal_child (this.show_button);
    	        return false;
            });

            revealer.leave_notify_event.connect ((event) => {
                revealer.set_reveal_child (false);
	            return false;
            });

            app_button.enter_notify_event.connect ((event) => {
                revealer.set_reveal_child (this.show_button);
                return false;
            });

            task_delete_button.enter_notify_event.connect ((event) => {
                revealer.set_reveal_child (this.show_button);
                return false;
            });
        }
    }
}
