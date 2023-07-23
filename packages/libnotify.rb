require 'package'

class Libnotify < Package
  description 'A library for sending desktop notifications.'
  homepage 'https://git.gnome.org/browse/libnotify'
  version '0.8.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/GNOME/libnotify/archive/#{version}.tar.gz"
  source_sha256 '7c0b252edecbf08db50d775f9e720ecc03c742fb97c25f3966a8b7a4bedf8133'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnotify/0.8.1_armv7l/libnotify-0.8.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnotify/0.8.1_armv7l/libnotify-0.8.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnotify/0.8.1_i686/libnotify-0.8.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnotify/0.8.1_x86_64/libnotify-0.8.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bff49fc3b4241e28454b3b2de0a5fc0a63eeda9d7b33211e14e6edf1d4ee81e4',
     armv7l: 'bff49fc3b4241e28454b3b2de0a5fc0a63eeda9d7b33211e14e6edf1d4ee81e4',
       i686: 'b2d008a6f2953b66605d75b55c688b0c80bab3c53f89fab8cc64f35fa8866153',
     x86_64: '87df4130086c957b893d67dc6833efdb37d8b8c7470dc0e26c3f70657d2e37b4'
  })

  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dman=false \
    -Ddocbook_docs=disabled \
    -Dtests=false \
    -Dgtk_doc=false \
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
