require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.13.93'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/freedesktop/fontconfig/archive/#{@_ver}.tar.gz"
  source_sha256 'f8452c78d1a12f6966455b0d584f89553b13e970b40644c3650f690ec0b3b4fe'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1a69463f6e980d9f77bc269fe4844023401b73c09db2addcd764f485ebda6c41',
      armv7l: '1a69463f6e980d9f77bc269fe4844023401b73c09db2addcd764f485ebda6c41',
        i686: '3a3f336a20d088faa0606ef94fba133f0b2d8eee12f0dbed834f3992512d2339',
      x86_64: '8987d30cfde81c8a96756b4bac7b37ec7a92db0d7262126e67ac46f813909e85',
  })

  depends_on 'expat'
  depends_on 'gperf'
  depends_on 'freetype_sub'
  depends_on 'jsonc'
  depends_on 'util_linux'
  depends_on 'graphite' => :build
  # Remove freetype and fontconfig before rebuilding this package.

  def self.patch
  # Fix failure from font directories not being writable.
    system "cat <<'EOF'> install-cache.py
#!/usr/bin/env python3
import sys
sys.exit() 
EOF"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --localstatedir=#{CREW_PREFIX}/cache \
    --default-library=both \
    -Ddoc=disabled \
    -Dfreetype2:harfbuzz=enabled \
    -Dfreetype2:default_library=both \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
