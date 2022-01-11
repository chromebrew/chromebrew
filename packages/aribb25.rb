require 'package'

class Aribb25 < Package
  description 'aribb25 is a basic implementation of the ARIB STD-B25 public standard.'
  homepage 'https://code.videolan.org/videolan/aribb25/'
  @_ver = '0.2.7'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/aribb25.git'
  git_hashtag @_ver

  depends_on 'pcsc_lite'

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
