require 'package'

class Dconf_editor < Package
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '43.0'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/dconf-editor/-/archive/#{version}/dconf-editor-#{version}.tar.bz2"
  source_sha256 'e7b127b865f56c00b31759461d239af9f7b8098e715dcde3e06896cd84b544ad'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50ff5adc092e785f07f089818a7c0fd1fd6229ea1b0e07e978f45b2f92ecd99c',
     armv7l: '50ff5adc092e785f07f089818a7c0fd1fd6229ea1b0e07e978f45b2f92ecd99c',
     x86_64: 'f4b41bd1febd465c57b534a8d04346e83a61b52904f0c9f8fbe7b88b28ace047'
  })

  depends_on 'dconf'
  depends_on 'gtk3'
  depends_on 'vala' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libhandy' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir test'
  end
end
