require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version "1.30-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1fca4640de2f9d4385f9cb86e15f284a3be2e748552507c44a6379b124d4a58',
     armv7l: 'e1fca4640de2f9d4385f9cb86e15f284a3be2e748552507c44a6379b124d4a58',
       i686: 'c6cc30e5c153e3b4ba852fcbb321f5d7e258deb042a79db4c57c809f40a1d86c',
     x86_64: '4dbcb80df65c6fee0612b3f0b142cba22a8c09f41f55fded7daa625acfc254a3'
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
