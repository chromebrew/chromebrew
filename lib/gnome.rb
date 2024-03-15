class GnomePostinstall
  @gnome_packages = []

  class << self
    attr_reader :gnome_packages
  end

  def self.add(package)
    # Usage:
    # GnomePostinstall.add 'package'
    @gnome_packages << [package]
  end

  def self.run
    puts "Running Gnome post_installs for #{@gnome_packages.join(', ')} ...".orange
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas" if File.file?("#{CREW_PREFIX}/bin/glib-compile-schemas")
    system "gio-querymodules #{CREW_LIB_PREFIX}/gio/modules" if File.file?("#{CREW_PREFIX}/bin/gio-querymodules")
    system "gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/*", exception: false if File.file?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
    system "update-mime-database #{CREW_PREFIX}/share/mime" if File.file?("#{CREW_PREFIX}/bin/update-mime-database")
    return unless File.file?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
