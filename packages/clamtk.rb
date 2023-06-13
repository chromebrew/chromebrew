require 'package'

class Clamtk < Package
  description 'An easy to use, light-weight, on-demand virus scanner for Linux systems.'
  homepage 'https://gitlab.com/dave_m/clamtk/'
  version '6.14'
  license 'GPL-1+'
  compatibility 'all'
  source_url 'https://gitlab.com/dave_m/clamtk/-/archive/v6.14/clamtk-v6.14.tar.bz2'
  source_sha256 'cda9f3afed9ebfb36093f6d1572af2834b0488cc60296774c6d241db5ad149be'

  depends_on 'clamav'
  depends_on 'perl_extutils_depends'
  depends_on 'perl_extutils_makemaker'
  depends_on 'perl_extutils_pkgconfig'
  depends_on 'perl_cairo'
  depends_on 'perl_cairo_gobject'
  depends_on 'perl_clone'
  depends_on 'perl_data_dumper'
  depends_on 'perl_file_spec'
  depends_on 'perl_file_temp'
  depends_on 'perl_io_file'
  depends_on 'perl_glib'
  depends_on 'perl_glib_object_introspection'
  depends_on 'perl_gtk3'
  depends_on 'perl_http_date'
  depends_on 'perl_http_request'
  depends_on 'perl_io_socket_ssl'
  depends_on 'perl_json'
  depends_on 'perl_locale_gettext'
  depends_on 'perl_lwp_protocol_https'
  depends_on 'perl_lwp_useragent'
  depends_on 'perl_net_http'
  depends_on 'perl_text_csv'
  depends_on 'perl_try_tiny'
  depends_on 'perl_uri'
  depends_on 'xdpyinfo'
  depends_on 'sommelier'

  no_compile_needed

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' clamtk"
  end

  def self.build
    clamtk = <<~EOF
      #!/bin/bash
      SCALE=1
      RESOLUTION=$(xdpyinfo | awk '/dimensions:/ { print $2 }' | cut -d'x' -f1)
      [[ $RESOLUTION -gt 1500 && $RESOLUTION -lt 2500 ]] && SCALE=1.5
      [[ $RESOLUTION -ge 2500 && $RESOLUTION -lt 3500 ]] && SCALE=2
      [[ $RESOLUTION -ge 3500 && $RESOLUTION -lt 4500 ]] && SCALE=2.5
      [[ $RESOLUTION -ge 4500 && $RESOLUTION -lt 5500 ]] && SCALE=3
      [[ $RESOLUTION -gt 5500 ]] && SCALE=3.5
      [ -z "$DISPLAY" ] && DISPLAY=':0'
      export GDK_BACKEND=x11
      export GDK_SCALE=$SCALE
      export DISPLAY=$DISPLAY
      #{CREW_PREFIX}/bin/clamtk.pl "$@"
    EOF
    File.write('clamtk.sh', clamtk)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/perl5/vendor_perl/ClamTk"
    FileUtils.mv 'lib/*.pm', "#{CREW_DEST_PREFIX}/share/perl5/vendor_perl/ClamTk"
    FileUtils.install 'clamtk.sh', "#{CREW_DEST_PREFIX}/bin/clamtk", mode: 0o755
    FileUtils.install 'clamtk', "#{CREW_DEST_PREFIX}/bin/clamtk.pl", mode: 0o755
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end

  def self.remove
    config_dir = "#{HOME}/.clamtk"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all clamtk config!'.orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
