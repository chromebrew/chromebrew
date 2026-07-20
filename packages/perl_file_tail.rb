require 'package'

class Perl_file_tail < Package
  description 'File::Tail - Perl extension for reading from continuously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version "1.3-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36456b3fed202ac79d4f1349fa912fc0a4d0e960532d373a98c2846b7a5095a9',
     armv7l: '36456b3fed202ac79d4f1349fa912fc0a4d0e960532d373a98c2846b7a5095a9',
       i686: '21669145b2a00faf9cb2d8d5689601de62859d44381acb8c3481990bb1645a09',
     x86_64: 'a0e06f3fde34001b2cb9c0893445f907d1d725e3afcd481a060b138628d0d7c5'
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
