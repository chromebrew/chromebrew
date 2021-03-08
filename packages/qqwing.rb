require 'package'

class Qqwing < Package
  description 'QQwing is a Sudoku puzzle generator and solver.'
  homepage 'https://qqwing.com/'
  version '1.3.4'
  compatibility 'all'
  source_url 'https://qqwing.com/qqwing-1.3.4.tar.gz'
  source_sha256 '1753736c31feea0085f5cfac33143743204f8a7e66b81ccd17e249ecafba802f'

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
