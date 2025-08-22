require 'buildsystems/meson'

class Colord < Meson
  description 'colord is a system service that makes it easy to manage, install and generate color profiles to accurately color manage input and output devices.'
  homepage 'https://www.freedesktop.org/software/colord/'
  version '1.4.8'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/hughsie/colord.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0381f90acd2648dc2d53b7bc5b3434ca609316b0aa34210ef021be295a79cb60',
     armv7l: '0381f90acd2648dc2d53b7bc5b3434ca609316b0aa34210ef021be295a79cb60',
     x86_64: '672f2258f86abb807a3f4ec179ef264baa5533cde742c8e67883d4311f13ab3d'
  })

  depends_on 'bash_completion'
  depends_on 'dbus'
  depends_on 'eudev' # R
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'gobject_introspection'
  depends_on 'gusb'
  depends_on 'lcms'
  depends_on 'libgudev'
  depends_on 'polkit'
  depends_on 'sqlite' # R
  depends_on 'vala' => :build

  # Building manpages fails due to the supposed lack of docbook-xsl-ns.
  meson_options "-Dsystemd=false -Ddocs=false -Dman=false -Ddaemon_user=#{USER}"
  run_tests
end
