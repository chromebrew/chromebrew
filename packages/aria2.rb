require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  @_ver = '1.35.0'
  version "#{@_ver}-2"
  compatibility 'all'
  source_url "https://github.com/aria2/aria2/releases/download/release-#{@_ver}/aria2-#{@_ver}.tar.xz"
  source_sha256 '1e2b7fd08d6af228856e51c07173cfcf987528f1ac97e04c5af4a47642617dfd'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b8082b1a4f9b8941f2891564046415abf544f113a452650d139c64253f4378f1',
     armv7l: 'b8082b1a4f9b8941f2891564046415abf544f113a452650d139c64253f4378f1',
       i686: '0e3b881cd0505eed0edb1ab898e5a272a3d9d950f9e9c9fd5ebc4d1d9a8c66d9',
     x86_64: '20cb509c94ac4776c39172fbf8b13c80088249ab6deffce4c4eb6d40081bbd71'
  })

  depends_on 'libgcrypt'

  def self.build
    system "env CFLAGS='-fuse-ld=gold -flto' CXXFLAGS='-fuse-ld=gold -flto' \
     LDFLAGS='-flto' \
     ./configure #{CREW_OPTIONS} \
      --without-libnettle \
      --with-libgcrypt \
      --disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
