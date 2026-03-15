require 'buildsystems/meson'

class Polkit < Meson
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://github.com/polkit-org/polkit'
  version '127'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/polkit-org/polkit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84490f0403cdfe2f6357dacf5af775af06e44112ae42c62d0bc8a10ef56703fc',
     armv7l: '84490f0403cdfe2f6357dacf5af775af06e44112ae42c62d0bc8a10ef56703fc',
     x86_64: '38ad0b4e78df4443940086461324526ef6fc67d5b3e8819c1e10c6e1a3e307f9'
  })

  depends_on 'dbus' => :build
  depends_on 'duktape' => :build
  depends_on 'elogind' # R
  depends_on 'expat' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build

  meson_options "-Dlibs-only=true \
                 -Dsession_tracking=elogind \
                 -Dsystemdsystemunitdir=#{CREW_PREFIX}/etc/elogind"

  meson_install_extras do
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX.to_s if ARCH.eql?('x86_64')
  end
end
