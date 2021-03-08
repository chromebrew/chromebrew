require 'package'

class Qqwing < Package
  description 'QQwing is a Sudoku puzzle generator and solver.'
  homepage 'https://qqwing.com/'
  @_ver = '1.3.4'
  version @_ver
  source_url "https://qqwing.com/qqwing-#{@_ver}.tar.gz"
  source_sha256 'dc5d61b4470862b190d437f8143d4090639c164d34461c4caa5c081c5c91e6cc'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system "make", "check"
  end
end
