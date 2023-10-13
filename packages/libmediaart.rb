# Adapted from Arch Linux libmediaart PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libmediaart/trunk/PKGBUILD

require 'package'

class Libmediaart < Package
  description 'Library tasked with managing, extracting and handling media art caches'
  homepage 'https://git.gnome.org/browse/libmediaart'
  version '1.9.6'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libmediaart.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediaart/1.9.6_armv7l/libmediaart-1.9.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediaart/1.9.6_armv7l/libmediaart-1.9.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediaart/1.9.6_i686/libmediaart-1.9.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediaart/1.9.6_x86_64/libmediaart-1.9.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'de847fbe6d813a6dd1ad6c1ab43e415253ceb87984e15c71421086041e1ed3dd',
     armv7l: 'de847fbe6d813a6dd1ad6c1ab43e415253ceb87984e15c71421086041e1ed3dd',
       i686: '0ec1513c6f5387aa6dfb6ad790fc3ff1a403c4d8fbf411a92da26dc308500c25',
     x86_64: '70a880d9fa59bd426bf5cc3f6118db4e0e74312f7c1b339b62827899824f9bf5'
  })

  depends_on 'gdk_pixbuf' => :build
  depends_on 'vala' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dimage_library=gdk-pixbuf \
      -Dtests=false \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
