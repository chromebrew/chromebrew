require 'package'

class Libmpeg2 < Package
  description 'libmpeg2 is a free MPEG-2 video stream decoder.'
  homepage 'https://libmpeg2.sourceforge.io/'
  @_ver = '0.5.1'
  version @_ver + '-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://salsa.debian.org/multimedia-team/mpeg2dec.git'
  git_hashtag 'debian/' + @_ver + '-9'

  depends_on 'libx11'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
    #system "sed '60d' bootstrap" # Our automake version is greater than 1.5
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-x"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
