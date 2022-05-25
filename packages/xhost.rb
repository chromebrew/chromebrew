require 'package'

class Xhost < Package
  description 'Server access control program for X'
  homepage 'https://github.com/freedesktop/xorg-xhost'
  version '1.0.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/xhost-1.0.8.tar.bz2'
  source_sha256 'a2dc3c579e13674947395ef8ccc1b3763f89012a216c2cc6277096489aadc396'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xhost/1.0.8_armv7l/xhost-1.0.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xhost/1.0.8_armv7l/xhost-1.0.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xhost/1.0.8_i686/xhost-1.0.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xhost/1.0.8_x86_64/xhost-1.0.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
     armv7l: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
       i686: 'd2fb32097557b95a2c824a1c5cdd3b3fd515ef99c5294350e6c6443ee0190cb0',
     x86_64: '8e108d51711153c01c45343af91d6b1c7bd493e4da823ebe85209eb5278ee25a'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxmu' # R

  def self.build
    system "./configure \
           --enable-ipv6 \
           --enable-tcp-transport \
           --enable-unix-transport \
           --enable-local-transport \
           #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
