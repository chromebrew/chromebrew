require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version "0.06-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1822bc953071d5c4cca00a7ce0d46fdaed1906c57d8ee9c66964639f64ccb2d8',
     armv7l: '1822bc953071d5c4cca00a7ce0d46fdaed1906c57d8ee9c66964639f64ccb2d8',
       i686: 'c36056355e1630d212436ee698beb68b4e9d77ddde45ac52b0ccb7e1f9b3f93b',
     x86_64: '2e37cc4826fcb3745be5642b5dd924b899d8fc2386bb22064c76443425ae080b'
  })

  depends_on 'perl_text_charwidth' => :build

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
