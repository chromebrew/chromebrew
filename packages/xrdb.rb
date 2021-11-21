require 'package'

class Xrdb < Package
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org'
  @_ver = '1.2.1'
  version @_ver
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{@_ver}"

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
