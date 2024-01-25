require 'package'

class Gtk_doc < Package
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.33.2-1'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk-doc/1.33/gtk-doc-1.33.2.tar.xz'
  source_sha256 'cc1b709a20eb030a278a1f9842a362e00402b7f834ae1df4c1998a723152bf43'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24057b08390fd7e509aa289cca5f34abb4aaee144597d628861e01aaec6fec7e',
     armv7l: '24057b08390fd7e509aa289cca5f34abb4aaee144597d628861e01aaec6fec7e',
       i686: 'ab074f841989d0f98f6bb7d32ee1ccc64c700e787da40f9af27c98a68b374fd2',
     x86_64: 'cbddae4808f786228f3456b8f633fa1a2b7435e8bf1c1dffa24cc640166ff765'
  })

  depends_on 'docbook_xml'
  depends_on 'glib'
  depends_on 'itstool'
  depends_on 'libxslt'
  depends_on 'py3_pygments' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
