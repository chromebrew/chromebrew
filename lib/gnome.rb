class GnomePostinstall
  @gnome_postinstall_count = 0

  def self.add
    @gnome_postinstall_count += 1
  end

  def self.run
    if @gnome_postinstall_count >= 1
      puts 'Running Gnome post_installs...'.orange
      system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas" if File.file?("#{CREW_PREFIX}/bin/glib-compile-schemas")
      system "gio-querymodules #{CREW_LIB_PREFIX}/gio/modules" if File.file?("#{CREW_PREFIX}/bin/gio-querymodules")
      system "gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/*", exception: false if File.file?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
      system "update-mime-database #{CREW_PREFIX}/share/mime" if File.file?("#{CREW_PREFIX}/bin/update-mime-database")
      return unless File.file?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
  end
end
