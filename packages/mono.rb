require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '5.10.1.47'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/mono/mono-5.10.1.47.tar.bz2'
  source_sha256 '90c237b5288f95f6fdab4ace1e36ab64a6369e2c9fddd462d604fd788e2545da'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.10.1.47-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.10.1.47-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.10.1.47-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.10.1.47-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2d1486554face0afdc68af43869136966674d929d3904296475971a2efc7fff3',
     armv7l: '2d1486554face0afdc68af43869136966674d929d3904296475971a2efc7fff3',
       i686: 'dee7c875844a58f2711fc890fc8a51c6defaf5cbaa57889dd7c64d73976ee9e3',
     x86_64: '32aae35fa5144e6d4d96c79d054491f9783083574e6390c92bd0d6ac29cde1c8',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--disable-maintainer-mode',
           '--disable-silent-rules',
           '--enable-nls=no'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
