require 'package'

class Libshine < Package
  description 'shine is a rapid fixed-point MP3 encoder.'
  homepage 'https://github.com/toots/shine/'
  @_ver = '3.1.1'
  version @_ver
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://github.com/toots/shine.git'
  git_hashtag @_ver

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
