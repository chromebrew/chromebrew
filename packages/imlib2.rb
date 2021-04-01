require 'package'

class Imlib2 < Package
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.7.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/enlightenment/imlib2-#{version}.tar.bz2"
  source_sha256 '033a6a639dcbc8e03f65ff05e57068e7346d50ee2f2fff304bb9095a1b2bc407'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.7.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fc1a05ee2eeaa200511b2bcebd2bdc70bd68192e1b3fabacba732cf48485a330',
     armv7l: 'fc1a05ee2eeaa200511b2bcebd2bdc70bd68192e1b3fabacba732cf48485a330',
       i686: 'fdfae01f5ec753ac700e9e49c7054c9dda42027c9e23c22e5297b92d868ae470',
     x86_64: 'e2bd849c909c8d6bf6b996be7a16479476916fdce072f8d924005318edde2219'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'giflib'
  depends_on 'libid3tag'
  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxext'

  def self.build
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc/imlib2 \
      --x-libraries=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
