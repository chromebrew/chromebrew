require 'package'

class Aribb24 < Package
  description 'aribb24 is a basic implementation of the ARIB STD-B24 public standard.'
  homepage 'https://github.com/nkoriyama/aribb24/'
  version '1.0.3'
  compatibility 'all'
  license 'LGPL-3'
  source_url 'https://github.com/nkoriyama/aribb24.git'
  git_hashtag "v#{@version}"

  depends_on 'libpng'

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
