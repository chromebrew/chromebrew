require 'buildsystems/meson'

class Colord < Meson
  description 'colord is a system service that makes it easy to manage, install and generate color profiles to accurately color manage input and output devices.'
  homepage 'https://www.freedesktop.org/software/colord/'
  version '1.4.7'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/hughsie/colord.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1997467d2cd378d26eb12f5846badd952fe66362f5a56523cf6b2c731c8585e5',
     armv7l: '1997467d2cd378d26eb12f5846badd952fe66362f5a56523cf6b2c731c8585e5',
     x86_64: '45ee103244fd062d2f578a6f0b7167c9ea33b5b3762430b7685eb2c51d888f16'
  })

  depends_on 'bash_completion'
  depends_on 'dbus'
  depends_on 'eudev' # R
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gusb'
  depends_on 'lcms'
  depends_on 'libgudev'
  depends_on 'polkit'
  depends_on 'vala' => :build

  # Building manpages fails due to the supposed lack of docbook-xsl-ns.
  meson_options "-Dsystemd=false -Ddocs=false -Dman=false -Ddaemon_user=#{USER}"
  run_tests
end
