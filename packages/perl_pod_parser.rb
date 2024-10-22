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
    aarch64: '3c6f74bb9c0c26489cb439eafac7eee329d67705030602508e1b8c71772ceeb2',
     armv7l: '3c6f74bb9c0c26489cb439eafac7eee329d67705030602508e1b8c71772ceeb2',
       i686: '89276cec5f6f47284346a22a284f4638d9e87cbbf70da8b86bf2c0313a3990ef',
     x86_64: 'e1e81a36e19337176855749dd5858e2ed6c7947f3e875de16a4657806afe6dbd'
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
