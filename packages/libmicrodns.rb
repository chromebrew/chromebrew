require 'package'

class Libmicrodns < Package
  description 'libmicrodns is a minimal cross-platform mDNS resolver and announcer.'
  homepage 'https://github.com/videolabs/libmicrodns/'
  @_ver = '0.2.0'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/videolabs/libmicrodns.git'
  git_hashtag @_ver

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
              -Dtests=enabled builddir"
    system "samu -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
