require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version "1.30-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-#{version.split('-').first}.tar.gz"
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c273bf48331403aba51193cd8cd280c015e601eab453d27be4956874891c6b8',
     armv7l: '3c273bf48331403aba51193cd8cd280c015e601eab453d27be4956874891c6b8',
       i686: 'b00fc8c8292a0b41d40ddfa135cbcf4bd0ecac3cc3f621641c9383d3474823dc',
     x86_64: '62f37fd2866ed89da455e316512e0774b1de03f90fe58caae5ee067287d4ea2f'
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
