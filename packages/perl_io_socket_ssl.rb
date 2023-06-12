require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.083-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.083.tar.gz'
  source_sha256 '904ef28765440a97d8a9a0df597f8c3d7f3cb0a053d1b082c10bed03bc802069'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.36_armv7l/perl_io_socket_ssl-2.083-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.36_armv7l/perl_io_socket_ssl-2.083-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.36_i686/perl_io_socket_ssl-2.083-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.36_x86_64/perl_io_socket_ssl-2.083-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1d1770afb6f9af958660a4173b741b57af9908010a5ae7380290311e222a866d',
     armv7l: '1d1770afb6f9af958660a4173b741b57af9908010a5ae7380290311e222a866d',
       i686: 'be6a4364ad541548b2318cc7f71d071a13fc97311f3eff1103312ae4f62e5759',
     x86_64: 'c9e86135dff99a3503eae0c99046050bb24219ed13e00ef2895678fd99a21125'
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
