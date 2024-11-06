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
    aarch64: '3298054323f1c4c8ba6c7e8bf12513f5394d74664959d90be527ec12bb3ce9fc',
     armv7l: '3298054323f1c4c8ba6c7e8bf12513f5394d74664959d90be527ec12bb3ce9fc',
       i686: '739b90f1d239a5d1eb5ac8949649125462d133c353b0c688199d681d47a2d922',
     x86_64: '73acad8fd9058958876da07ab4fe6825ab8a6e86ce443fbcf0a79ea71721a94d'
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
