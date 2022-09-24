require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  @_ver = '3.92.0'
  version @_ver.to_s
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gcr/-/archive/#{@_ver}/gcr-#{@_ver}.tar.bz2"
  source_sha256 '94db38a729bc3725e3ab64589222f574dbba9b30bf52cbcb7266a38f67a0e55b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0_armv7l/gcr-3.92.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0_armv7l/gcr-3.92.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0_i686/gcr-3.92.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0_x86_64/gcr-3.92.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e89038cc2cb54d472aac9b431881284a8844bbbbca49f0ad63b6c1480abf9a29',
     armv7l: 'e89038cc2cb54d472aac9b431881284a8844bbbbca49f0ad63b6c1480abf9a29',
       i686: 'eb3972c1901413040c8d0e9abaad63b219358c0d63d1484acd85cb29b0352f9b',
     x86_64: '28c34c8d44abea29b4c067dc36f9740cb4013a90f9c9a4bbc0c73850d386f837'
  })

  depends_on 'cairo'
  depends_on 'desktop_file_utilities'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gnupg'
  depends_on 'graphite'
  depends_on 'gtk3'
  depends_on 'hicolor_icon_theme'
  depends_on 'libgcrypt'
  depends_on 'libjpeg'
  depends_on 'libsecret'
  depends_on 'libxslt'
  depends_on 'pango'
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
