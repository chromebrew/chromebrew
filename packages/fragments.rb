require 'buildsystems/meson'

class Fragments < Meson
  description 'Fragments is an easy to use BitTorrent client for the GNOME desktop environment.'
  homepage 'https://gitlab.gnome.org/World/Fragments'
  version '2.1.1'
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

  depends_on 'dbus' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glibc' => :build
  depends_on 'glib' => :build
  depends_on 'graphene' => :build
  depends_on 'gtk4' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'libadwaita' => :build
  depends_on 'openssl' => :build
  depends_on 'pango' => :build
  depends_on 'rust' => :build
  depends_on 'transmission' # L
  depends_on 'zlibpkg' => :build

  gnome
end
