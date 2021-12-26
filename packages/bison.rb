require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'https://www.gnu.org/software/bison/'
  @_ver = '3.8.2'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/bison/bison-#{@_ver}.tar.lz"
  source_sha256 'fdf98bfe82abb04a34d4356753f7748dbbd2ef1221b1f202852a2b5ce0f78534'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    puts 'Notice: Bison checks take a very long time.'.yellow
    system 'make', 'check'
  end
end
