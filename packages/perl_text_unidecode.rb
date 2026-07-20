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
    aarch64: '23d24d71ced51a442e8f5a5302c48d148eb956385a3a2e32bf5f1f21bda9441a',
     armv7l: '23d24d71ced51a442e8f5a5302c48d148eb956385a3a2e32bf5f1f21bda9441a',
       i686: '7c1129f050930faf73f94585829c31306b9a2a5f9368f1858f927f5a77d1d9f5',
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
