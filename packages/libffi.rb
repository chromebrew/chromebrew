require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.4.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14026a74658574e2f7dfe5516f16bff43ed8d0c4ed3c65764216c72602cb6b54',
     armv7l: '14026a74658574e2f7dfe5516f16bff43ed8d0c4ed3c65764216c72602cb6b54',
       i686: '6fa26f0ad0e3d78315dbb50e7fc1f059711d75beae1d10d4a23c425cbb5da653',
     x86_64: '4a2afb9850e7ab6b723a9df9279282479ce60a1db4fdb336b60e2244d327902a'
  })

  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    # system "make check"         # DejaGNU required
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
