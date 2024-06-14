require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version '20221114-perl5.40'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/H/HA/HAARG/Mozilla-CA-20221114.tar.gz'
  source_sha256 '701bea67be670add5a102f9f8c879402b4983096b1cb0e20dd47d52d7a10666b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd5e175a919101f31b59cdfe5b5a417a69ec90f932dfbda1b0bc8a34c3d8ae20',
     armv7l: 'dd5e175a919101f31b59cdfe5b5a417a69ec90f932dfbda1b0bc8a34c3d8ae20',
       i686: '2469e94b03a6c762ce8bf0e6a91cec12174cee0f3377dc84aca55258d4b38b19',
     x86_64: 'f232499a01c67a5c63212e77fbad67015d9c8942337b69cd72fbf569cdef6251'
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
