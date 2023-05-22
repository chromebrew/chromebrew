require 'package'

class Perl_net_ssleay < Package
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version '1.92-perl5.36'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.92.tar.gz'
  source_sha256 '47c2f2b300f2e7162d71d699f633dd6a35b0625a00cbda8c50ac01144a9396a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92_armv7l/perl_net_ssleay-1.92-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92_armv7l/perl_net_ssleay-1.92-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92_i686/perl_net_ssleay-1.92-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92_x86_64/perl_net_ssleay-1.92-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e1556a75adbb106daa2c4378c238caefb783c0639868b8ebc66d32f1650e6eb',
     armv7l: '6e1556a75adbb106daa2c4378c238caefb783c0639868b8ebc66d32f1650e6eb',
       i686: 'a2d76b5d37e390359a50c5f8b61dfabd9e0860b7766f27ed8e4caa8d575e88d1',
     x86_64: 'bcd0aa317e6c2f0edffec3e46cb8e5722280ed0ebc2d6d4eb382f66ea627ea7b'
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
