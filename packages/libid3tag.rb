require 'package'

class Libid3tag < Package
  description 'libid3tag is a library for reading and (eventually) writing ID3 tags'
  homepage 'https://www.underbit.com/products/mad/'
  version '0.15.1b'
  compatibility 'all'
  source_url 'ftp://ftp.mars.org/pub/mpeg/libid3tag-0.15.1b.tar.gz'
  source_sha256 '63da4f6e7997278f8a3fef4c6a372d342f705051d1eeb6a46a86b03610e26151'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libid3tag-0.15.1b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libid3tag-0.15.1b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libid3tag-0.15.1b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libid3tag-0.15.1b-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '614d3daa64a65218669d392862e0adb52d6a97e29e0964e83519a0f43e2e7ae0',
     armv7l: '614d3daa64a65218669d392862e0adb52d6a97e29e0964e83519a0f43e2e7ae0',
       i686: '2572d5b5926bff440114e0bf3542f1ad308d990761792f9206a30b5ddfc070e7',
     x86_64: '49449a7a53c03eaa8293427db604db65954123c4e1fdbe1207aae80d934da070',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
