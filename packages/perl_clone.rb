require 'package'

class Perl_clone < Package
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version '0.46-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GA/GARU/Clone-0.46.tar.gz'
  source_sha256 'aadeed5e4c8bd6bbdf68c0dd0066cb513e16ab9e5b4382dc4a0aafd55890697b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.36_armv7l/perl_clone-0.46-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.36_armv7l/perl_clone-0.46-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.36_i686/perl_clone-0.46-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.36_x86_64/perl_clone-0.46-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '999e09aae6f5eb3148caa00f777a0d519e16560451e1aa028964948f61950330',
     armv7l: '999e09aae6f5eb3148caa00f777a0d519e16560451e1aa028964948f61950330',
       i686: 'b23cdf8e2122b45c25fec000fe141f9992bffcb0033054aacf670e0ec82a6393',
     x86_64: '14a3ccaebb9b4ed05fd03e9750d4206e6f2039831012a43e83ce06d082ee0670'
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
