require 'package'

class Perl_extutils_pkgconfig < Package
  description 'Simplistic interface to pkg-config'
  homepage 'https://metacpan.org/pod/ExtUtils::PkgConfig'
  version '1.16-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz'
  source_sha256 'bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66b3c4b9becc1e41f1264eeb3a9f67dd817143f7d2cd9476bf73abee485740b3',
     armv7l: '66b3c4b9becc1e41f1264eeb3a9f67dd817143f7d2cd9476bf73abee485740b3',
       i686: '6f6e2329e7befd2a7ffaafbd26864e435a75433b7a0727c935d43890b160104a',
     x86_64: 'fa72060389eeb6b5d39d7ff1ef7207d9d68ba598184d1699986e46f191330eb2'
  })

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
