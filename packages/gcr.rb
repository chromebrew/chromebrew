require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  @_ver = '3.92.0'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gcr/-/archive/#{@_ver}/gcr-#{@_ver}.tar.bz2"
  source_sha256 '94db38a729bc3725e3ab64589222f574dbba9b30bf52cbcb7266a38f67a0e55b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0-1_armv7l/gcr-3.92.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0-1_armv7l/gcr-3.92.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0-1_i686/gcr-3.92.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.92.0-1_x86_64/gcr-3.92.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0617bb385b1e183456bfcf68d95e14c5a031b0ce11c654ee9efd75e9185d21b4',
     armv7l: '0617bb385b1e183456bfcf68d95e14c5a031b0ce11c654ee9efd75e9185d21b4',
       i686: 'f7e78aa0f37cb98ad07d88a32dc993d027de9be7369193f4e4eb9e2a9cc4fcc3',
     x86_64: '11faa5ee0fead928462f8dd0489f33da216cc0fec4bf544956ed94e4c58ab589'
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
