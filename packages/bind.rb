require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.12.0'
  source_url 'https://www.isc.org/downloads/file/bind-9-12-0/'
  source_sha256 '29870e9bf9dcc31ead3793ca754a7b0236a0785a7a9dc0f859a0bc42e19b3c82'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "openssl"
  depends_on "libcap"
  depends_on "readline"
  depends_on "diffutils"

  def self.build
    system "BUILD_CC=gcc ./configure \
                --with-randomdev=no \
                --with-ecdsa=yes \
                --with-gost=yes \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX}"  
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
