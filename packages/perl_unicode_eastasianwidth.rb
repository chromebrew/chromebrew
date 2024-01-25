require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version '12.0-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95257f63295ee7c5ca7869a321ae73ce4cb8a3a6de09f5be2f1571191da06b9d',
     armv7l: '95257f63295ee7c5ca7869a321ae73ce4cb8a3a6de09f5be2f1571191da06b9d',
       i686: 'ca8ae9e257f0b3b351fc3bb523efd787ca15d9f38117e3ab09f5c892ab178551',
     x86_64: '5ad064ebc83e7c7ec96e0ee4039b4d09d9212cdb6cad8fc4f1914f4cc0797e61'
  })

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
