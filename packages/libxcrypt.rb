require 'package'

class Libxcrypt < Package
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  @_ver = '4.4.18'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/archive/v#{@_ver}.tar.gz"
  source_sha256 '3801f0263a8596b15ec466343fc1fdc4ad4ec7416c51e038a3528fd47f3be01a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcrypt-4.4.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcrypt-4.4.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcrypt-4.4.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcrypt-4.4.18-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5be9496841308529004f767f689f9d0ad681700e12db213f2f94742aec99e1d3',
     armv7l: '5be9496841308529004f767f689f9d0ad681700e12db213f2f94742aec99e1d3',
       i686: 'c06e88bb39f787c294dbbdb5497887a6b58b24d586965ece1d9915dd3cd82e0c',
     x86_64: '36f1ed8e9d2889c62c2eb4f9d98808fcae9400d376e1b6cd8367550998a8188c'
  })

  def self.build
    system 'autoreconf -fi'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-static \
      --enable-hashes=strong,glibc \
      --enable-obsolete-api=no \
      --disable-failure-tokens"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
