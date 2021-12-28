require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  @_ver = '0.11.3'
  version @_ver
  license 'BSD, BSD-2, BSD-4, ISC'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libbsd.git'
  git_hashtag @_ver

  depends_on 'libmd'

  def self.build
    FileUtils.mkdir_p 'm4'
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
