require 'package'

class Gcr_4 < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '4.0.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gcr/-/archive/#{version}/gcr-#{version}.tar.bz2"
  source_sha256 'e33e5daae4715a4701a37c05775ea4ab6da17cb005adedf617f3b367be018e4b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr_4/4.0.0_armv7l/gcr_4-4.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr_4/4.0.0_armv7l/gcr_4-4.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr_4/4.0.0_i686/gcr_4-4.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcr_4/4.0.0_x86_64/gcr_4-4.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '03c546cb1101caa00361ee1c22f4f0d81097fd3f4ee01e1ce387daf16e3dd58b',
     armv7l: '03c546cb1101caa00361ee1c22f4f0d81097fd3f4ee01e1ce387daf16e3dd58b',
       i686: '960f12ec46ce219d63b689fa8b8cb01fa13595d4190cdd08dd6e4525c8f240d6',
     x86_64: 'a670172596e9332928f0fa05eceb3fcbcb58ead70b146dc62fee567e8a2a87ff'
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
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'p11kit' # R
  depends_on 'gcc_lib' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
