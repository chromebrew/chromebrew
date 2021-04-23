require 'package'

class Cairomm_1_16 < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  @_ver = '1.16.0'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://www.cairographics.org/releases/cairomm-#{@_ver}.tar.xz"
  source_sha256 '7e881492c5f9f546688c31160deb742c166fc4c68b6b8eb9920c00a0f0f144f9'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/cairomm_1_16-1.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/cairomm_1_16-1.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/cairomm_1_16-1.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/cairomm_1_16-1.16.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '59ca0664657952e1296639082e8352e26ad1b9792208b4a2b713c64178f73e77',
     armv7l: '59ca0664657952e1296639082e8352e26ad1b9792208b4a2b713c64178f73e77',
       i686: 'e874a3fc54b12a36625063808ac69fe76dbd77eed044f300cf51170359f4bd4a',
     x86_64: '69ad2d194716615b38b13eb321bd019c61cceb1124c787a990524d792d1eac6d'
  })

  depends_on 'cairo'
  depends_on 'libsigcplusplus3'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-examples=false \
    -Dbuild-tests=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
