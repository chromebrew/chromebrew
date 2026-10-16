require 'buildsystems/meson'

class Polkit < Meson
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://github.com/polkit-org/polkit'
  version '128'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/polkit-org/polkit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1e832a790b4790150c98a22da9693e7dc889fddf2010d6f87b5023886441c01',
     armv7l: 'c1e832a790b4790150c98a22da9693e7dc889fddf2010d6f87b5023886441c01',
     x86_64: 'bd2b5aaaa802f07a2cacfc458f6fafff6e5e0512585824b3b44df366fe9fd875'
  })

  depends_on 'dbus' => :build
  depends_on 'duktape' => :build
  depends_on 'elogind' => :library
  depends_on 'expat' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build

  meson_options "-Dlibs-only=true \
                 -Dsession_tracking=elogind \
                 -Dsystemdsystemunitdir=#{CREW_PREFIX}/etc/elogind"

  meson_install_extras do
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX.to_s if ARCH.eql?('x86_64')
  end
end
