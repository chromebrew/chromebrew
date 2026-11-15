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
    aarch64: 'b7659eed7c5fef373eab13e0c2a5701546bf126938b0a861330c4fe6d720b4b4',
     armv7l: 'b7659eed7c5fef373eab13e0c2a5701546bf126938b0a861330c4fe6d720b4b4',
       i686: '06fa7ecb7145c60aa8b9e54d57ba8a699708fcc11122f2060fe83841e1098ff7',
     x86_64: 'abba6ba4f40cfc3d572f8dcbf9418c01eec8afb182cb546b5e12699e6a5b02b4'
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
