require 'package'

class Perl_clone < Package
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version '0.46-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GA/GARU/Clone-0.46.tar.gz'
  source_sha256 'aadeed5e4c8bd6bbdf68c0dd0066cb513e16ab9e5b4382dc4a0aafd55890697b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38_armv7l/perl_clone-0.46-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38_armv7l/perl_clone-0.46-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38_i686/perl_clone-0.46-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38_x86_64/perl_clone-0.46-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '985dc562b3b11162f044fd54dd1e8c17d03168288c6a0e69a631e6a46bee7a9a',
     armv7l: '985dc562b3b11162f044fd54dd1e8c17d03168288c6a0e69a631e6a46bee7a9a',
       i686: 'b059f12d35e0d74b2eccde54e72e7eacf863e2a5386f26b341232700b0979687',
     x86_64: 'b7c9d555cc0ae6013990d21d73cd24d2d6bc7c643a3aaa6eb3a907737dddf347'
  })

  depends_on 'glibc' # R

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
