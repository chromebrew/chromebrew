require 'package'

class Slang < Package
  description 'S-Lang is a multi-platform programmer\'s library designed to allow a developer to create robust multi-platform software.'
  homepage 'http://www.jedsoft.org/slang/'
  version '2.3.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.jedsoft.org/releases/slang/slang-2.3.3.tar.bz2'
  source_sha256 'f9145054ae131973c61208ea82486d5dd10e3c5cdad23b7c4a0617743c8f5a18'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/slang/2.3.3_armv7l/slang-2.3.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/slang/2.3.3_armv7l/slang-2.3.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/slang/2.3.3_i686/slang-2.3.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/slang/2.3.3_x86_64/slang-2.3.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '880cf91fde278118fc476633095172a1e7b6d4beb0f87fbd13cfc9a294320509',
     armv7l: '880cf91fde278118fc476633095172a1e7b6d4beb0f87fbd13cfc9a294320509',
       i686: '4ccef4c49d5d25d944278242b75bde60a06d3bdb949bcec3433fcb3c02ed1e80',
     x86_64: '777a1a2a147ee1778a33d15fb1955aa41b1e67f3160d90bbba4c9be2f9a46206'
  })

  depends_on 'glibc' # R
  depends_on 'libpng' # R
  depends_on 'pcre' # R
  depends_on 'zlibpkg' # R
  depends_on 'gcc' # R

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS} --without-x"

    # force to compile in sequential since slang Makefile doesn't work in parallel
    system 'make', '-j1'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
