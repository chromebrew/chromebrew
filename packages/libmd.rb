require 'package'

class Libmd < Package
  description 'libmd provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  @_ver = '1.0.4'
  version @_ver
  license 'BSD-3, BSD-2, ISC, Beerware, public-domain'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libmd.git'
  git_hashtag @_ver

  def self.build
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
