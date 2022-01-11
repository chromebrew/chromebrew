require 'package'

class Aribb24 < Package
  description 'aribb24 is a basic implementation of the ARIB STD-B24 public standard.'
  homepage 'https://github.com/nkoriyama/aribb24/'
  @_ver = '1.0.3'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/nkoriyama/aribb24.git'
  git_hashtag 'v' + @_ver

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
