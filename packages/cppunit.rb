require 'package'

class Cppunit < Package
  description 'CppUnit is the C++ port of the famous JUnit framework for unit testing.'
  homepage 'https://www.freedesktop.org/wiki/Software/cppunit'
  version '1.15.1'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/cppunit-1.15.1.tar.gz'
  source_sha256 '89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1_armv7l/cppunit-1.15.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1_armv7l/cppunit-1.15.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1_i686/cppunit-1.15.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1_x86_64/cppunit-1.15.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ff33e323513beb49457df2f8fd8d5642998664a4eef9e0f1095aa5f99d79e05d',
     armv7l: 'ff33e323513beb49457df2f8fd8d5642998664a4eef9e0f1095aa5f99d79e05d',
       i686: '91c258a319a9bb7fc7052e4ed40b057a653125b5a4a9b17d21145d603088bf28',
     x86_64: '2020d8901ded8bb1123f82ab598b77af77cd08392204a939f1d229c915c353cb'
  })

  depends_on 'doxygen' => ':build'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-static"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
