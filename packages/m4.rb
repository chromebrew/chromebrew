require 'package'

class M4 < Package
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.19'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/m4/m4-1.4.19.tar.xz'
  source_sha256 '63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96'

  depends_on 'libsigsegv'

  def self.build
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
