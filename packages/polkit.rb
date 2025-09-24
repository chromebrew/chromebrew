require 'buildsystems/meson'

class Polkit < Meson
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://github.com/polkit-org/polkit'
  version '126'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/polkit-org/polkit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4590a3ed9d697d83cfd8572f099149c312523a2c6c746c4bd8de1b9372a330a',
     armv7l: 'b4590a3ed9d697d83cfd8572f099149c312523a2c6c746c4bd8de1b9372a330a',
     x86_64: '52ba4765904dd0ecbbb774643bf2e113ff87148eb1a22603162349779869f887'
  })

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
  run_tests
end
