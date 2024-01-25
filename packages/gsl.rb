require 'package'

class Gsl < Package
  description 'The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.'
  homepage 'https://www.gnu.org/software/gsl/'
  version '2.6'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gsl/gsl-2.6.tar.gz'
  source_sha256 'b782339fc7a38fe17689cb39966c4d821236c28018b6593ddb6fd59ee40786a8'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'aef58137cae2223ebc52ee81039e04768d32c837edbbddcc25d144cdd0e1983b',
     armv7l: 'aef58137cae2223ebc52ee81039e04768d32c837edbbddcc25d144cdd0e1983b',
       i686: 'ff59679e039167ed10758575b49780f688d0e70dd5ee9bcc45d3546bae168f46',
     x86_64: 'b08296445edc313d9c44a66a73a4a62c264c828fb8ee41e9d42d819742cee4f4'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
