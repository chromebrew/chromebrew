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
     aarch64: '423e0f0ce0893269aca65177a9eaee299eef8b1be2e728c77988ae3e9e741037',
      armv7l: '423e0f0ce0893269aca65177a9eaee299eef8b1be2e728c77988ae3e9e741037',
        i686: 'a083bbc6d31677f4eb795433bffbe75468783f0d2d3fe9d95db9140f09ab7ce2',
      x86_64: '2a7c0fc6c91b8b4217d7b69b0fa607a963ecbf17c689008c989841c89a610160',
  })

  depends_on 'libgcrypt'
  
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
    FileUtils.ln_s "#{CREW_PREFIX}/bin/#{CREW_BUILD}-aria2c", "#{CREW_DEST_PREFIX}/bin/aria2c"
  end
end
