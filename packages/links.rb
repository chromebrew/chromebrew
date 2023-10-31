require 'package'

class Links < Package
  description 'Links is a lynx-like text WWW browser with tables and frames.'
  homepage 'http://links.twibright.com/'
  version '2.28'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://links.twibright.com/download/links-2.28.tar.bz2'
  source_sha256 '2fd5499b13dee59457c132c167b8495c40deda75389489c6cccb683193f454b4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.28_armv7l/links-2.28-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.28_armv7l/links-2.28-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.28_i686/links-2.28-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.28_x86_64/links-2.28-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'afa89a2b2fabf27e2fdfa83ff6f528b66cd52a7effc69202c6e8c5a805fec617',
     armv7l: 'afa89a2b2fabf27e2fdfa83ff6f528b66cd52a7effc69202c6e8c5a805fec617',
       i686: '2513d64a717eff502b96c9e5be41b4df4e78d44fe847d886337a9fb720f267e9',
     x86_64: '0640a3a0c2e2b35a1745542b070f8ed859c21821721a93d78f5597e74a8ba9b6'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2'
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'lzma'
  depends_on 'openssl'
  depends_on 'xzutils' # R
  depends_on 'zlibpkg'
  depends_on 'zstd' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
