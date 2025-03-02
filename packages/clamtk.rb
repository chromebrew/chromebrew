require 'package'

class Clamtk < Package
  description 'An easy to use, light-weight, on-demand virus scanner for Linux systems.'
  homepage 'https://gitlab.com/dave_m/clamtk/'
  version '6.18'
  license 'GPL-1+'
  compatibility 'x86_64'
  source_url 'https://github.com/dave-theunsub/clamtk.git'
  git_hashtag "v#{version}"

  depends_on 'clamav'
  depends_on 'gdk_base'
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
  depends_on 'perl_net_ssleay'
  depends_on 'perl_text_csv'
  depends_on 'perl_try_tiny'
  depends_on 'perl_uri'
  depends_on 'xdpyinfo'
  depends_on 'sommelier'

  gnome
  no_compile_needed

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' clamtk"
  end

  def self.install
    system 'gunzip clamtk.1.gz'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/perl5/vendor_perl/ClamTk"
    FileUtils.mv Dir['lib/*.pm'], "#{CREW_DEST_PREFIX}/share/perl5/vendor_perl/ClamTk"
    FileUtils.install 'clamtk', "#{CREW_DEST_PREFIX}/bin/clamtk", mode: 0o755
    FileUtils.install 'clamtk.1', "#{CREW_DEST_MAN_PREFIX}/man1/clamtk.1", mode: 0o644
    FileUtils.install 'clamtk.desktop', "#{CREW_DEST_PREFIX}/share/applications/clamtk.desktop", mode: 0o644
    FileUtils.install 'images/clamtk.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/clamtk.png", mode: 0o644
  end

  def self.postremove
    config_dir = "#{HOME}/.clamtk"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all clamtk config!'.orange
      Package.agree_to_remove(config_dir)
    end
  end
end
