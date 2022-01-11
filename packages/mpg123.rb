require 'package'

class Mpg123 < Package
  description 'Fast console MPEG Audio Player and decoder library.'
  homepage 'http://www.mpg123.org/'
  version '1.29.3'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/mpg123/files/mpg123/1.29.3/mpg123-1.29.3.tar.bz2'
  source_sha256 '963885d8cc77262f28b77187c7d189e32195e64244de2530b798ddf32183e847'

  depends_on 'alsa_lib'
#  depends_on 'cras'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-audio=alsa" # should we also use pulseaudio and/or jack?
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
