require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-3_armv7l/perl_text_charwidth-0.04-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-3_armv7l/perl_text_charwidth-0.04-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-3_i686/perl_text_charwidth-0.04-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-3_x86_64/perl_text_charwidth-0.04-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5cdc12e2f3e5364befe19ed143aad3dae7f1f0402e0a5cd88e679b54dd586858',
     armv7l: '5cdc12e2f3e5364befe19ed143aad3dae7f1f0402e0a5cd88e679b54dd586858',
       i686: 'd1338224a059f68a880d875cf9bd3e4e0063ca387295bf64d610ca0297aa347d',
     x86_64: '835d7b09829d483ed99d39d56986363c43ee7cd2966b69eaa0819592d8f91785'
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
