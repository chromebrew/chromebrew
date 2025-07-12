require 'package'

class Perl_pod_parser < Package
  description 'Perl Pod::Parser - base class for creating POD filters and translators'
  homepage 'https://metacpan.org/pod/Pod::Parser'
  version "1.67-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.67.tar.gz'
  source_sha256 '5deccbf55d750ce65588cd211c1a03fa1ef3aaa15d1ac2b8d85383a42c1427ea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '066cb7d78247f2f580ca69832e8d610ea8b62a1a5bd578140fe3586b012c593e',
     armv7l: '066cb7d78247f2f580ca69832e8d610ea8b62a1a5bd578140fe3586b012c593e',
       i686: 'b93232e9b4616e2b691d70d70d9c86ea78eb563e9e97284471ed468ab330d67b',
     x86_64: '874b9fe46939fbd32376a04559d390886b041ef9ab88b0d4ea651792d349f3ec'
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
