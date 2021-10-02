require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.4.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/expat/expat/2.4.1/expat-2.4.1.tar.xz'
  source_sha256 'cf032d0dba9b928636548e32b327a2d66b1aab63c4f4a13dd132c2d1d2f2fb6a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.4.1_armv7l/expat-2.4.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.4.1_armv7l/expat-2.4.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.4.1_i686/expat-2.4.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.4.1_x86_64/expat-2.4.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1f044a7aecace21975cb528e625a1364d485f976eb3c12e53edf85006efe2980',
     armv7l: '1f044a7aecace21975cb528e625a1364d485f976eb3c12e53edf85006efe2980',
       i686: '5731a665443b8e029da85c5207352e380d476c6a9bbc4810fff23fa5bb0451e4',
     x86_64: 'e5f8529e86f68486309d884676fdd72186a6ece1864d72ac97151a2d907690d4'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure \
       #{CREW_OPTIONS} \
       #{CREW_ENV_OPTIONS} \
       --enable-shared \
       --enable-static \
       --with-pic"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
