require 'package'

class Perl_file_tail < Package
  description 'Perl extension for reading from continously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version '1.3'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b229def8b897d284dbb4358272c80d66efcf5a07a5a754af6845667b57296fb3',
     armv7l: 'b229def8b897d284dbb4358272c80d66efcf5a07a5a754af6845667b57296fb3',
       i686: 'e3a076ec4e1fa188338a6830cb88f13dd99b7dcc1863010a79a441ee32525d65',
     x86_64: '3ddfb4ca1947794e63e375a7b68bab4e676f565ac2b7b1ceca3bcb6c4f45d9aa',
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
