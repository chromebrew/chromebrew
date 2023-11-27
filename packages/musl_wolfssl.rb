# Adapted from Arch Linux wolfssl PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=wolfssl

require 'package'

class Musl_wolfssl < Package
  description 'small, fast, portable implementation of TLS/SSL for embedded devices to the cloud formerly CyaSSL'
  homepage 'https://www.wolfssl.com/'
  version '5.1.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/wolfSSL/wolfssl/archive/v5.1.1-stable.tar.gz'
  source_sha256 'd3e0544dbe7e9587c0f6538cdc671b6492663bb7a4281819538abe6c99cdbd92'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_wolfssl/5.1.1_armv7l/musl_wolfssl-5.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_wolfssl/5.1.1_armv7l/musl_wolfssl-5.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_wolfssl/5.1.1_i686/musl_wolfssl-5.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_wolfssl/5.1.1_x86_64/musl_wolfssl-5.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c47ed88e5ebbdd796a131bda2de60ddc8662ba489e22e949e4acc62df099ff82',
     armv7l: 'c47ed88e5ebbdd796a131bda2de60ddc8662ba489e22e949e4acc62df099ff82',
       i686: '0d18e3a80a7078974d752145c7204c07f0fff0a332cd96632adbdb28d5b00bdf',
     x86_64: '714c1aabfc97632c2e10f3376b9a3b82ce3008a48a1f99a3f33d0b62ade61637'
  })

  depends_on 'musl_native_toolchain'

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./autogen.sh"
    system "#{MUSL_ENV_OPTIONS} ./configure \
    --prefix=#{CREW_MUSL_PREFIX} \
    --sysconfdir=#{CREW_MUSL_PREFIX}/etc \
    --disable-bump \
    --disable-debug \
    --disable-examples \
    --enable-all-crypto \
    --enable-fastmath \
    --enable-fasthugemath \
    --enable-certgen \
    --enable-curve25519 \
    --enable-curve448 \
    --enable-ed25519 \
    --enable-ed448 \
    --enable-sessioncerts \
    --enable-fortress \
    --enable-keygen \
    --enable-libssh2 \
    --enable-openssh \
    --enable-opensslall \
    --enable-opensslextra \
    --enable-reproducible-build \
    --enable-static \
    --enable-writedup"

    system "#{MUSL_ENV_OPTIONS} make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
