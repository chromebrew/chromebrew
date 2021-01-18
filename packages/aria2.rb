require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  @_ver = '1.35.0'
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://github.com/aria2/aria2/releases/download/release-#{@_ver}/aria2-#{@_ver}.tar.xz"
  source_sha256 '1e2b7fd08d6af228856e51c07173cfcf987528f1ac97e04c5af4a47642617dfd'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '29b2e520194d7ed596ea0bfa4f75d46d2e74462ea5dc8fd21d4638bdc8e7b932',
      armv7l: '29b2e520194d7ed596ea0bfa4f75d46d2e74462ea5dc8fd21d4638bdc8e7b932',
        i686: 'eb3ceec16c9bc7f07f0a5ebf51753545b3ff0c57fc1af7ab3e9e95bdc13ba164',
      x86_64: 'f8a4926df1f68968bddd3cae7784842a94b39e200bfc6e0332a73389b775dd08',
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'sqlite'
  depends_on 'zlibpkg'

  def self.build
    system "env CFLAGS='-fuse-ld=gold -flto' CXXFLAGS='-fuse-ld=gold -flto' \
     ./configure #{CREW_OPTIONS} \
      --without-libnettle \
      --with-libgcrypt \
      --disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/#{ARCH}-cros-linux-gnu-aria2c", "#{CREW_DEST_PREFIX}/bin/aria2c"
  end
end
