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
    aarch64: '62f39d24c9917c1d5a3c42362d2a372fb20b1711e95727d2a0ce25a9deb99380',
     armv7l: '62f39d24c9917c1d5a3c42362d2a372fb20b1711e95727d2a0ce25a9deb99380',
       i686: 'bad1f36c2a0364953a5bcd450d0d86548bc2b5431ecfd17feb9bd5197050bfae',
     x86_64: 'eef7805b258aad0c205fec73ddfaba9a455348a2e4700ee9a549884f42663ddc'
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
