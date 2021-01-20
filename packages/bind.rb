require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.17.8'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.8-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.8-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.8-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c757c886c9760396405166ee258b1953935ea3a61e40e6490c44aecbf64a5041',
      armv7l: 'c757c886c9760396405166ee258b1953935ea3a61e40e6490c44aecbf64a5041',
        i686: '54a28fd25b2602ac2fec3781e148c6ce9222537978b6ab79bc9457a0ab5ce534',
      x86_64: '0d5568f9e16d5b76fd8da2815efce5dbbecb435ee99e8757141c10e8edd9539c',
  })

  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'libuv'
  depends_on 'libidn2'

  def self.build
    system "git config --global advice.detachedHead false"
    system 'git clone --depth=1 -b v9_17_8 https://gitlab.isc.org/isc-projects/bind9.git'
    Dir.chdir 'bind9' do
      system 'pip3 install ply==3.11'
      system 'autoreconf -fi'
      system "env CFLAGS='-DDIG_SIGCHASE -flto=auto' ./configure \
              #{CREW_OPTIONS} \
               --enable-fixed-rrset \
               --enable-full-report \
               --with-openssl \
               --with-libidn2 \
               --disable-maintainer-mode"
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
