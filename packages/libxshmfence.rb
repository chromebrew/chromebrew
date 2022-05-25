require 'package'

class Libxshmfence < Package
  description 'A library that exposes a event API on top of Linux futexes'
  homepage 'http://t2sde.org/packages/libxshmfence.html'
  version '1.3.1'
  license 'custom'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-1.3.1.tar.xz'
  source_sha256 '1129f95147f7bfe6052988a087f1b7cb7122283d2c47a7dbf7135ce0df69b4f8'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxshmfence/1.3.1_armv7l/libxshmfence-1.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxshmfence/1.3.1_armv7l/libxshmfence-1.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxshmfence/1.3.1_i686/libxshmfence-1.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxshmfence/1.3.1_x86_64/libxshmfence-1.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80960ac0229518c53314b7da0647329860ca1f3369076624e866267a555bf178',
     armv7l: '80960ac0229518c53314b7da0647329860ca1f3369076624e866267a555bf178',
       i686: '80a7cd36137b0ba04e1775277667abd21ae43bc1415a5e53d5ebaa211ab78bcd',
     x86_64: 'cab374aabaa29a0e9723ec3242efcdee5b196cec9398056977fdc813fcc3bb9b'
  })

  depends_on 'glibc' # R
  depends_on 'xorg_proto' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
