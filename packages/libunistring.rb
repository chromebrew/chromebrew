require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.10-1'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libunistring/libunistring-0.9.10.tar.xz'
  source_sha256 'eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/0.9.10-1_armv7l/libunistring-0.9.10-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/0.9.10-1_armv7l/libunistring-0.9.10-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/0.9.10-1_i686/libunistring-0.9.10-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/0.9.10-1_x86_64/libunistring-0.9.10-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1987a956d1d5faf7f1364cd56c61536ca7727782c199d910bbef609109095a32',
     armv7l: '1987a956d1d5faf7f1364cd56c61536ca7727782c199d910bbef609109095a32',
       i686: 'd9d4a7741d8ae40b02593d6b4e89f3c4c0da8a0be709a1275045f024853f4c21',
     x86_64: '3073ee4151dd8c96b87c21cb1f1e183c29c0da7c5a8e51f45641387c237b316c'
  })

  depends_on 'glibc'

  def self.build
    system "./configure #{CREW_ENV_OPTIONS} #{CREW_OPTIONS} \
      --enable-static \
      --enable-shared"
    system 'make'
  end

  # def self.check
  # system "make", "check"
  # end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
