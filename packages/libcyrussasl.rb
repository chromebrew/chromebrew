require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27-2'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz'
  source_sha256 '26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.27-2_armv7l/libcyrussasl-2.1.27-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.27-2_armv7l/libcyrussasl-2.1.27-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.27-2_i686/libcyrussasl-2.1.27-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.27-2_x86_64/libcyrussasl-2.1.27-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5271b29ef9e1bbcd92d597ec69750f89b9a62a70b1c4ceb900cae769da7ad27a',
     armv7l: '5271b29ef9e1bbcd92d597ec69750f89b9a62a70b1c4ceb900cae769da7ad27a',
       i686: 'd62620954fbd9ba7fd6279c7412dccb56a91318e0ed0150c1fc0efbf23314587',
     x86_64: 'f1bc40fa4566b8928447b59387a49268e4aa541a3e80d7f059e74e7d62e17a63'
  })

  depends_on 'diffutils' => :build

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --enable-static \
      --enable-shared \
      --with-cxx-shared"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
