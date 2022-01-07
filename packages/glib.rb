require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.71.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.0_armv7l/glib-2.71.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.0_armv7l/glib-2.71.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.0_i686/glib-2.71.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.0_x86_64/glib-2.71.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7472a12f0c69ee1d7a519cd4f25a4b8da016d2505b4a14e27c199f16d250a2c1',
     armv7l: '7472a12f0c69ee1d7a519cd4f25a4b8da016d2505b4a14e27c199f16d250a2c1',
       i686: 'a43a085224bc3cb30d5857e194f11c1e8cb64f69d233c78c74db664535ff8f34',
     x86_64: 'c5c670452bf4dfc8001fbbb69ec35055af657d4f8e926502cb0e3657631439f3'
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
