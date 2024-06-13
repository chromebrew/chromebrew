require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.085-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.085.tar.gz'
  source_sha256 '95b2f7c0628a7e246a159665fbf0620d0d7835e3a940f22d3fdd47c3aa799c2e'
  binary_compression 'tar.zst'

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
