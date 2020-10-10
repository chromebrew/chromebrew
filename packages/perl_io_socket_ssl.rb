require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.068'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.068.tar.gz'
  source_sha256 '4420fc0056f1827b4dd1245eacca0da56e2182b4ef6fc078f107dc43c3fb8ff9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.068-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.068-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.068-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.068-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '290136e4383f9f88e8d9ca18d73c41ed6eb96f7d81f1c3baa3c6ef3087283560',
     armv7l: '290136e4383f9f88e8d9ca18d73c41ed6eb96f7d81f1c3baa3c6ef3087283560',
       i686: '7cb1cfb6c47f5cc3f817867af6a883e403316258d68361028615b8b0373ad772',
     x86_64: 'ffc3268461e4c52068243e8a1480bc829d420c284d842c02975d1175493f8558',
  })

  depends_on 'perl'

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
