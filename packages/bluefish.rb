require 'buildsystems/autotools'

class Bluefish < Autotools
  description 'Bluefish is a powerful editor targeted towards programmers and webdevelopers'
  homepage 'https://bluefish.openoffice.nl/index.html'
  version '2.4.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.bennewitz.com/bluefish/stable/source/bluefish-#{version}.tar.bz2"
  source_sha256 'b2641f9ff8033719e02c519c5ddb4bdadbd7ff73ef252e9287d512c4770377c5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68be867b19c7605f29adb3e2660822d6c7ccf243860d25c0a737f3fa049e1017',
     armv7l: '68be867b19c7605f29adb3e2660822d6c7ccf243860d25c0a737f3fa049e1017',
     x86_64: 'efed0f50f6ae07ac025f1d631fe5a04bb9bfa8efd6004df472210d156b09b34c'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'enchant' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnome_icon_theme'
  depends_on 'gtk3' => :library
  depends_on 'gucharmap' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'hicolor_icon_theme'
  depends_on 'hunspell'
  depends_on 'libxml2' => :library
  depends_on 'mesa'
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'python3' => :library
  depends_on 'shared_mime_info'
  depends_on 'wayland_protocols'
  depends_on 'xcb_util'
  depends_on 'xdg_base'
  depends_on 'zlib' => :library

  gnome
  print_source_bashrc

  autotools_build_extras do
    File.write '10-bluefish', <<~EOF
      alias bluefish="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland #{CREW_PREFIX}/bin/bluefish"
    EOF
  end

  autotools_install_extras do
    FileUtils.install '10-bluefish', "#{CREW_DEST_PREFIX}/etc/env.d/10-bluefish", mode: 0o644
    # Remove conflicts with shared_mime_info files.
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/mime"
  end

  def self.postremove
    config_dir = "#{HOME}/.bluefish"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all bluefish config!'.orange
      Package.agree_to_remove(config_dir)
    end
  end
end
