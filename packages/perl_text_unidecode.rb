require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version '1.30-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ecfa8e0ed890718428d85991af35a66d697183921e17700142822155f3920df0',
     armv7l: 'ecfa8e0ed890718428d85991af35a66d697183921e17700142822155f3920df0',
       i686: '67d8385f2ea0c3be3e7096be54caca940758cc91d18bfb564876bdaac95b8c62',
     x86_64: '1801ecff3570deca2fe22ecc47364a36c4a5a03765cea70e9c8820f8f925d4be'
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
