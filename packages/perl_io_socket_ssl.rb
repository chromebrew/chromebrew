require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version "2.085-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.085.tar.gz'
  source_sha256 '95b2f7c0628a7e246a159665fbf0620d0d7835e3a940f22d3fdd47c3aa799c2e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a4e91e12ea60ad3735550e33a8b3d02fc0e70681e1e131f1571d3069b6b16c2',
     armv7l: '4a4e91e12ea60ad3735550e33a8b3d02fc0e70681e1e131f1571d3069b6b16c2',
       i686: '9f7e88cb139c43bf7e0a2e0c262dde0cdd49a60048db12ab614803baee6d1708',
     x86_64: 'e72ee9f49b9f3d7a6b7ae26ac629d5571ad9458eac3bbeaf932f0bc775c32b18'
  })

  depends_on 'perl_net_ssleay' => :build
  depends_on 'perl_mozilla_ca' => :build

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
