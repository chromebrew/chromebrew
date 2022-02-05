require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.71.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.1_armv7l/glib-2.71.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.1_armv7l/glib-2.71.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.1_i686/glib-2.71.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.1_x86_64/glib-2.71.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dc75987cfd4ded17f8ac719d80dc3ff1508e5e0876f739cf78ede64c03f4e2d0',
     armv7l: 'dc75987cfd4ded17f8ac719d80dc3ff1508e5e0876f739cf78ede64c03f4e2d0',
       i686: 'b59137669a2c2fad2c8cf39db576678412559826e7ad69ae34851ed1ae13d827',
     x86_64: 'b1b45e35cfddc29d84c1a73d87cc0447fedcd16fbf1813eae64f23d1b8f7444c'
  })

  depends_on 'shared_mime_info' # L
  depends_on 'py3_six' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'util_linux' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
