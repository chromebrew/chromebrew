require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version '1.30-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-3_armv7l/perl_text_unidecode-1.30-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-3_armv7l/perl_text_unidecode-1.30-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-3_i686/perl_text_unidecode-1.30-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-3_x86_64/perl_text_unidecode-1.30-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ccbe0cfc4c936ec4a7b56c08cea0eb00fd3624ab25d51bf8b1da66fea6d9cf11',
     armv7l: 'ccbe0cfc4c936ec4a7b56c08cea0eb00fd3624ab25d51bf8b1da66fea6d9cf11',
       i686: '8bed41f94818af7023c983bdf2e0974a1c7465056b22d1e20e6c9761dfa764af',
     x86_64: '8580a3912f3760c45fbb0fb0a8b9d5faf2e963dcd699e64bfb52a7be300bc5f0'
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
