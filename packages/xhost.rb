require 'package'

class Xhost < Package
  description 'Server access control program for X'
  homepage 'https://github.com/freedesktop/xorg-xhost'
  version '1.0.8'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/app/xhost-1.0.8.tar.bz2'
  source_sha256 'a2dc3c579e13674947395ef8ccc1b3763f89012a216c2cc6277096489aadc396'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
     armv7l: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
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
