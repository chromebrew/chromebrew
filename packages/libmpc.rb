require 'package'

class Libmpc < Package
  description 'Musepack is an audio compression format with a strong emphasis on high quality.'
  homepage 'https://www.musepack.net/'
  @_ver = 'r495'
  version @_ver
  license 'BSD and LGPL-2+'
  compatibility 'all'
  source_url 'https://salsa.debian.org/multimedia-team/libmpc.git'
  git_hashtag 'debian/2%0.1_' + @_ver + '-2'

  depends_on 'libcue'

  def self.patch
    system "for i in debian/patches/*.patch ; do patch -Np1 -i \${i}; done"
  end

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
