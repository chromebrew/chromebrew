require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.18.93'
  version @_ver
  compatibility 'all'
  source_url "https://wayland.freedesktop.org/releases/wayland-#{@_ver}.tar.xz"
  source_sha256 '6df611caec469d05564c8cacda8d4df368c318f0336ebd2fbef27fb59db26927'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.93-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.93-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.93-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.93-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'cec31727a1aab8b4a24a412fe48f2653022d907740dde88b26831ae9688628ec',
      armv7l: 'cec31727a1aab8b4a24a412fe48f2653022d907740dde88b26831ae9688628ec',
        i686: '155100efa8567cab4d2eff45cac6fe58e578fb506b6b2efa84a7b18842fb7a09',
      x86_64: '3536fe7d389c55e2a3c8c1d7bf2f4c21482523ebbe8245d692d08d598cfc3822',
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
