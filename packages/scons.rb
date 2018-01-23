require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'http://scons.org/'
  version '3.0.1'
  source_url 'https://prdownloads.sourceforge.net/scons/scons-3.0.1.tar.gz'
  source_sha256 '24475e38d39c19683bc88054524df018fe6949d70fbd4c69e298d39a0269f173'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scons-3.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scons-3.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scons-3.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scons-3.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '15e77d81c7c8ea494594896659d552e88d7d71daea7d8fb88b59d582277d33fa',
     armv7l: '15e77d81c7c8ea494594896659d552e88d7d71daea7d8fb88b59d582277d33fa',
       i686: '8c7249140fcecd97daf1cdaa7bf3df76281d89ff20697b9990abe6b8e3905484',
     x86_64: 'c1196e05cda0e471b61d6948cb02dd74a32e8c68794901bf63d72a6e7a0d135e',
  })

  depends_on 'python27'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
  end
end
