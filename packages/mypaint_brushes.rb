require 'package'

class Mypaint_brushes < Package
  description 'Brushes used by MyPaint and other software using libmypaint.'
  homepage 'http://mypaint.org/'
  @_ver = '2.0.2'
  version @_ver
  license 'CC0-1.0'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint-brushes.git'
  git_hashtag 'v' + @_ver

  depends_on 'libmypaint'

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
