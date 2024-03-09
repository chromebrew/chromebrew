require 'package'

class Fragments < Package
  description 'Fragments is an easy to use BitTorrent client for the GNOME desktop environment.'
  homepage 'https://gitlab.gnome.org/World/Fragments'
  version '2.1'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/World/Fragments.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27daf87476325d131cd74a2dff2b15cdd6e39f041f8f2233e6dc9c8c3a589121',
     armv7l: '27daf87476325d131cd74a2dff2b15cdd6e39f041f8f2233e6dc9c8c3a589121',
     x86_64: 'a6d40669d6abea2b3da664675c713eaf53ce2d9ba335c75d2c3e777346425ba0'
  })

  depends_on 'dbus'
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'openssl' # R
  depends_on 'pango' # R
  depends_on 'rust' => :build
  depends_on 'transmission' # L
  depends_on 'zlibpkg' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
