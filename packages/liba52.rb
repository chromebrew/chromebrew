require 'package'

class Liba52 < Package
  description 'liba52 is a free library for decoding ATSC A/52 streams.'
  homepage 'http://liba52.sourceforge.net/'
  @_ver = '0.7.4'
  version @_ver + '-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://salsa.debian.org/multimedia-team/a52dec.git'
  git_hashtag 'debian/' + @_ver + '-20'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  def self.build
    system './bootstrap'
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
