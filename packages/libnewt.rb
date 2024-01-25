require 'package'

class Libnewt < Package
  description 'Not Eriks Windowing Toolkit - text mode windowing with slang'
  homepage 'https://pagure.io/newt'
  version '0.52.21'
  license 'LGPL-2'
  compatibility 'all'
  source_url "https://releases.pagure.org/newt/newt-#{version}.tar.gz"
  source_sha256 '265eb46b55d7eaeb887fca7a1d51fe115658882dfe148164b6c49fccac5abb31'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'd1813f44254d795347e412bfffcc6a86b4dffc934db3e0341b5072f7a7518b12',
     armv7l: 'd1813f44254d795347e412bfffcc6a86b4dffc934db3e0341b5072f7a7518b12',
       i686: 'e4850288e06cdc7f35233e8beeb2ead16fd934c0eac6afea7c8b26666feaf20a',
     x86_64: '07ebbb1fe4cfe931a583e1195d1340fec0387a1bd5c83ee8a0fda9754730f185'
  })

  depends_on 'gpm'
  depends_on 'libxcrypt'
  depends_on 'popt'
  depends_on 'tcl' => :build
  depends_on 'py3_pygments' => :build

  def self.patch
    patch_url = 'http://deb.debian.org/debian/pool/main/n/newt/newt_0.52.21-4.debian.tar.xz'
    patch_sha256 = '163f2f58bf4d0ac8a0907a1c2530a02d7c178b88c53fb98ee69d4b33bc86187d'

    system('curl', '-Lf', patch_url, '-o', 'zippatches.tar.xz')
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest(File.read('./zippatches.tar.xz')) == patch_sha256
    system('tar', '-xf', 'zippatches.tar.xz')

    system('for i in `cat debian/patches/series`; do patch -p 1 < debian/patches/$i; done')
    system "echo '#define USE_INTERP_RESULT 1' >> config.h"
  end

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-gpm-support"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
