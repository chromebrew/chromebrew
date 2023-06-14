require 'package'

class Gmp < Package
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version '6.2.1' # Do not use @_ver here, it will break the installer.
  license 'LGPL-3+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gmplib.org/download/gmp/gmp-6.2.1.tar.lz'
  source_sha256 '2c7f4f0d370801b2849c48c9ef3f59553b5f1d3791d070cffb04599f9fc67b41'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmp/6.2.1_armv7l/gmp-6.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmp/6.2.1_armv7l/gmp-6.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmp/6.2.1_i686/gmp-6.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmp/6.2.1_x86_64/gmp-6.2.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c9a07f1b3654f087dff322a5a0d5cbe98fba1e7c5b483621702655a0c879c152',
     armv7l: 'c9a07f1b3654f087dff322a5a0d5cbe98fba1e7c5b483621702655a0c879c152',
       i686: '2428a10b21a6b6bfaca1d2bd85b5c2adcd05aa3f48b6e9712d96ff84fa525478',
     x86_64: '50847bd14c11de841c7c74696e2ff4503253bbaacd38e9ffb31814d6ccfb76f3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  no_patchelf

  def self.build
    system 'filefix'
    system "./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-cxx"
    system 'make'
  end

  def self.check
    # Run tests on armv7l after install
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
