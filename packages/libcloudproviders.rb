# Adapted from Arch Linux libcloudproviders PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcloudproviders/trunk/PKGBUILD

require 'package'

class Libcloudproviders < Package
  description 'DBus API that allows cloud storage sync clients to expose their services'
  homepage 'https://gitlab.gnome.org/World/libcloudproviders'
  version '0.3.1'
  license 'LGPL3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/World/libcloudproviders.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcloudproviders/0.3.1_armv7l/libcloudproviders-0.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcloudproviders/0.3.1_armv7l/libcloudproviders-0.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcloudproviders/0.3.1_i686/libcloudproviders-0.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcloudproviders/0.3.1_x86_64/libcloudproviders-0.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '66bdf01e15334ebf3116560bfe420c135c88985c9aec1b9681e723a85f1d7643',
     armv7l: '66bdf01e15334ebf3116560bfe420c135c88985c9aec1b9681e723a85f1d7643',
       i686: 'e82c90e2d4b30c72c236ac229f7897a5fffc7b0f642928645b6137517d46d414',
     x86_64: 'c09ca53402d15711f03131517aadeb610bac7ae3a4269ec30ac9e9719ecf5fae'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
