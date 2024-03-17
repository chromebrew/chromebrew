# Adapted from Arch Linux libgtop PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libgtop/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libgtop < Autotools
  description 'A library for collecting system monitoring data'
  homepage 'https://gitlab.gnome.org/GNOME/libgtop'
  version '2.41.3'
  license 'LGPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgtop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5b703d524437a1bde822f3af46bcc1f298ec5212fdccbb788ef46d8a5b8b5cc',
     armv7l: 'b5b703d524437a1bde822f3af46bcc1f298ec5212fdccbb788ef46d8a5b8b5cc',
     x86_64: '2fc3ae048d0d38f6b106912a047cde29dfbd132f2bb9ba52d7068d6f2ead3a30'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libxau' # R

  gnome
end
