require 'package'

class Swig < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '4.1.1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/swig/swig/swig-4.1.1/swig-4.1.1.tar.gz'
  source_sha256 '2af08aced8fcd65cdb5cc62426768914bedc735b1c250325203716f78e39ac9b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1_armv7l/swig-4.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1_armv7l/swig-4.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1_i686/swig-4.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1_x86_64/swig-4.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b5837e879e54df39836c0ba11705c4bf9e6d0cba1a9517766a0ce65ce3b189a1',
     armv7l: 'b5837e879e54df39836c0ba11705c4bf9e6d0cba1a9517766a0ce65ce3b189a1',
       i686: '6cf56f60437498ef3b08ef4939680d9592a005cc75b868972af9affd8f13d842',
     x86_64: '382bbf4c71d2508667b628a94f386db95cdbc0a36458dd9c83de6a28f8628975'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre' => :build
  depends_on 'pcre2' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
