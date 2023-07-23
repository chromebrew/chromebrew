require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.083-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.083.tar.gz'
  source_sha256 '904ef28765440a97d8a9a0df597f8c3d7f3cb0a053d1b082c10bed03bc802069'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.38_armv7l/perl_io_socket_ssl-2.083-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.38_armv7l/perl_io_socket_ssl-2.083-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.38_i686/perl_io_socket_ssl-2.083-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.083-perl5.38_x86_64/perl_io_socket_ssl-2.083-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '72b6e9439455bdf3459ef2de98b7ee18fa2ce368e4adb97b4289a524dfd1bf4e',
     armv7l: '72b6e9439455bdf3459ef2de98b7ee18fa2ce368e4adb97b4289a524dfd1bf4e',
       i686: '2b7854b845d30ca033b00dc9571fb104db829c57c6d0e393e3eb83fa4ca2f5ab',
     x86_64: '0b64638e8d88d5d4956839c7b91e2d21f981f54ecb3746e22773a2aeae7e851c'
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
