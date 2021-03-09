require 'package'

class Clutter_gtk < Package
  description 'The Clutter Gtk package is a library providing facilities to integrate Clutter into GTK+ applications.'
  homepage 'https://wiki.gnome.org/Projects/Clutter'
  compatibility 'all'
  @_app = File.basename(__FILE__, '.rb').tr('_', '-')
  @_fullver = '1.8.4'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clutter_gtk-1.8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clutter_gtk-1.8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clutter_gtk-1.8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clutter_gtk-1.8.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: '7f759c259b71f86c1e13ec5ffb8e0add079b5dfa4cddae06d81700db6834ac7d',
     armv7l: '7f759c259b71f86c1e13ec5ffb8e0add079b5dfa4cddae06d81700db6834ac7d',
       i686: '499108e196161dffd762aff54ffa8bbd338863c9d9cc8c2af54fd5728d11cb7d',
     x86_64: '3b5b60ce00a67815def67ff992aac8caf89fb4ee0ef68d7a51c857ce30a3461e'
  })
  
  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
