require 'package'

class Polkit < Package
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://www.freedesktop.org/wiki/Software/polkit/'
  version '0.120-7a99b'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xry111/polkit.git'
  git_branch 'xry111/js91'
  git_hashtag '7a99b67429b48357b36d29b3b650783af4b51ac1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/polkit/0.120-7a99b_armv7l/polkit-0.120-7a99b-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/polkit/0.120-7a99b_armv7l/polkit-0.120-7a99b-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/polkit/0.120-7a99b_i686/polkit-0.120-7a99b-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/polkit/0.120-7a99b_x86_64/polkit-0.120-7a99b-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '41b4b9c4dc68b2f1960f571f09632422187fb3d726fccf90fe48e48539564e4c',
     armv7l: '41b4b9c4dc68b2f1960f571f09632422187fb3d726fccf90fe48e48539564e4c',
       i686: 'dc377359a5b4c77cd0fa429ff11134614b5c6766cb55dfbf85b4a3bcb29ba77c',
     x86_64: 'ced0c15bbae3c494e287a217268fd5cb62e133d71a347b6d8224392f96c2d43f'
  })

  depends_on 'js91'
  depends_on 'elogind'
  depends_on 'gtk_doc' => :build
  depends_on 'gobject_introspection' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dsession_tracking=libelogind \
    -Dsystemdsystemunitdir=#{CREW_PREFIX}/etc/elogind/ \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
