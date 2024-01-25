require 'package'

class Libgc < Package
  description 'libgc is a library for garbage collection in Rust.'
  homepage 'https://github.com/softdevteam/libgc'
  version '8.0.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/libg/libgc/libgc_8.0.4.orig.tar.gz'
  source_sha256 '436a0ddc67b1ac0b0405b61a9675bca9e075c8156f4debd1d06f3a56c7cd289d'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'ae5052fb0631ca207dee9178f18da34ed5bb1e8da8c45249dc23e6260763e7f8',
     armv7l: 'ae5052fb0631ca207dee9178f18da34ed5bb1e8da8c45249dc23e6260763e7f8',
       i686: 'f2d7240df24b0b25bc8984ae39492d6639b492e88430992bcf99307656b1dbdb',
     x86_64: 'f9fd0199862aad3b417597c9921dd5399a59e9f41f388cbb829b198626912a3c'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-static \
            --enable-shared \
            --enable-docs"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
