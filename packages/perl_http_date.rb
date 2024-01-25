require 'package'

class Perl_http_date < Package
  description 'Date conversion routines'
  homepage 'https://metacpan.org/pod/HTTP::Date'
  version '6.05-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Date-6.05.tar.gz'
  source_sha256 '365d6294dfbd37ebc51def8b65b81eb79b3934ecbc95a2ec2d4d827efe6a922b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d5092501452b15fc777c7ab5ca2d5070e639380e897bc41edf012bc73d89d8d',
     armv7l: '7d5092501452b15fc777c7ab5ca2d5070e639380e897bc41edf012bc73d89d8d',
       i686: '1b3244db2c512a0a05484b5a1ae1314033f11704a8dcba60c02be67e2957e6ec',
     x86_64: 'd20110c5c831c7bfb8b62d64da59b0cbd72c9b9c5baaebae0225b0319ed58a5d'
  })

  no_compile_needed

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
