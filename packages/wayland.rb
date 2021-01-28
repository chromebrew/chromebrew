require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.19.0'
  version @_ver
  compatibility 'all'
  source_url "https://wayland.freedesktop.org/releases/wayland-#{@_ver}.tar.xz"
  source_sha256 'baccd902300d354581cd5ad3cc49daa4921d55fb416a5883e218750fef166d15'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.19.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.19.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.19.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.19.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ff5f655f517f263a92c0416f25bb6a16168cd7adf7fb1dcaec752b293068fa9a',
      armv7l: 'ff5f655f517f263a92c0416f25bb6a16168cd7adf7fb1dcaec752b293068fa9a',
        i686: '35a7c95bab108da2483b99d7a63703b2e2f65d202cab699d1cfc721f0c4a172e',
      x86_64: 'fc509f738cb90e5f67e612389d209b94018751b87dd37452d9ed1762bd54f8f3',
  })

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libffi'
  depends_on 'libxml2'
  depends_on 'libxslt'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Ddocumentation=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
