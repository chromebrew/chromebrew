require 'buildsystems/autotools'

class Cppunit < Autotools
  description 'CppUnit is the C++ port of the famous JUnit framework for unit testing.'
  homepage 'https://www.freedesktop.org/wiki/Software/cppunit'
  version '1.15.1-1'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/cppunit-1.15.1.tar.gz'
  source_sha256 '89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1-1_armv7l/cppunit-1.15.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1-1_armv7l/cppunit-1.15.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1-1_i686/cppunit-1.15.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppunit/1.15.1-1_x86_64/cppunit-1.15.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '34994f0771929f0990b528a73bdeba8989e609f9dec999cc8d9e08506dd91c45',
     armv7l: '34994f0771929f0990b528a73bdeba8989e609f9dec999cc8d9e08506dd91c45',
       i686: 'e67306e63a5e85ed48b15937ec40cd6fa462368e0a5f1d2136eba4dfb4673220',
     x86_64: 'd6cab6f3a67a23be49b7760e237f74f346146d76d2fa2ab689553f285bf6cfd7'
  })

  depends_on 'doxygen' => ':build'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
