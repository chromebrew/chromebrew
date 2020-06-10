require 'package'

class Xhost < Package
  description 'Server access control program for X'
  homepage 'https://github.com/freedesktop/xorg-xhost'
  version '1.0.7'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/xhost-1.0.7.tar.bz2'
  source_sha256 '93e619ee15471f576cfb30c663e18f5bc70aca577a63d2c2c03f006a7837c29a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xhost-1.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xhost-1.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xhost-1.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xhost-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6bc7b1b1ac3da2a29d255dc12116d8fb7558b7a951c39694e793a17de3118f0f',
     armv7l: '6bc7b1b1ac3da2a29d255dc12116d8fb7558b7a951c39694e793a17de3118f0f',
       i686: '6b52588ce97148da0b44ca76a7934b9f921834fe3d3bc3165c9085a46fb20d87',
     x86_64: '81710af7e1d0a9193739e8fd4f87b469be75ceadf364f5628504927a7f715ab2',
  })

  depends_on 'xorg_lib'

  def self.build
    system './configure',
           '--enable-ipv6',
           '--enable-tcp-transport',
           '--enable-unix-transport',
           "--prefix=#{CREW_PREFIX}",
           '--enable-local-transport',
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

