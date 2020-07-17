require 'package'

class Perl_carp_clan < Package
  description 'Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version '6.08'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34f5a19b0f6d50b9c808b706aacac94c851608545f253ee812f1c34baea93b92',
     armv7l: '34f5a19b0f6d50b9c808b706aacac94c851608545f253ee812f1c34baea93b92',
       i686: '38300c01e5721e453e498a09037d5e6ca5e221544eeca93dbbdd5fefcbfff6dc',
     x86_64: '777456ea1e8bde75969472f97838926b3ed40a5c02c1bad27d5416f87488e86d',
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
