require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  @_ver = '3.40.0'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gcr/-/archive/#{@_ver}/gcr-#{@_ver}.tar.bz2"
  source_sha256 '659a49bac1c713a743894845c82ef53ccc7326dcce1879b1af0ab502ec10e7ab'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.40.0-1_armv7l/gcr-3.40.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.40.0-1_armv7l/gcr-3.40.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.40.0-1_i686/gcr-3.40.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr/3.40.0-1_x86_64/gcr-3.40.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e1062d5322f4dd084436459fe26e76af0a6118e3a1b0f88329dacae0617c0d96',
     armv7l: 'e1062d5322f4dd084436459fe26e76af0a6118e3a1b0f88329dacae0617c0d96',
       i686: 'd927f0e2bdcfa4542d68d4ddc9371b67776f2724b19bd0847029dee6d9751244',
     x86_64: 'a7a7c8ecd1472f17269e33624ba2e91ca4dd699613f833ce9b566889a81ab45f'
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
  depends_on 'libxslt'
  depends_on 'pango'
  depends_on 'vala' => :build

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
