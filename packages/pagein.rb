require 'package'

class Pagein < Package
  description 'Pagein is a tool that forces pages that are in swap to be paged in back to memory.'
  homepage 'https://kernel.ubuntu.com/~cking/pagein/'
  version '0.00.05'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/pagein/pagein-0.00.05.tar.gz'
  source_sha256 '3f81409f6227887212083c585abf5143a082dde2bbcab1d2ae8c74b6d294e8b3'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '6a51692fb5beb3c0ea8c01773c005e312afcb777ae41bee0f2e5ba87cd38cad3',
     armv7l: '6a51692fb5beb3c0ea8c01773c005e312afcb777ae41bee0f2e5ba87cd38cad3',
       i686: '651edceb92170eca73cc53056f6999ffe8dd3f896f4c997b064effdb1f8c0740',
     x86_64: 'b488a5ff3a3cc89a40386a1a1de0c0c449e3587356052d69b9fbc776afa527ec'
  })

  def self.build
    system 'make',
           "BINDIR=#{CREW_PREFIX}/bin",
           "MANDIR=#{CREW_PREFIX}/share/man/man1"
  end

  def self.install
    system 'make',
           "DESTDIR=#{CREW_DEST_DIR}",
           "BINDIR=#{CREW_PREFIX}/bin",
           "MANDIR=#{CREW_PREFIX}/share/man/man1",
           'install'
  end
end
