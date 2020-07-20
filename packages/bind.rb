require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.17.3'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7dd57b241a5ef20ff4ecc36b90e442c3ae35b5f60aa890791226f54bfe188c8',
     armv7l: 'b7dd57b241a5ef20ff4ecc36b90e442c3ae35b5f60aa890791226f54bfe188c8',
       i686: 'a548e1980be640b0f541df3a1a4ad6f61483e39ba323b17159dccc68cd47286c',
     x86_64: '60b6dabf560447184b9022188c74965ec22fd40becbf49d526b5ea36f0cc2c39',
  })

  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'libuv'

  def self.build
    system 'git clone https://gitlab.isc.org/isc-projects/bind9.git'
    Dir.chdir 'bind9' do
      system 'git checkout v9_17_3'
      system 'pip3 install ply==3.11'
      system 'autoreconf -fi'
      system './configure',
             "--prefix=#{CREW_PREFIX}",
             '--disable-maintainer-mode',
             "--libdir=#{CREW_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'bind9' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
      system 'pip3 uninstall -y ply'
      system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I ply==3.11"
    end
  end
end
