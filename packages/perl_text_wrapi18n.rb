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
    aarch64: 'bc29675fd4834f11e5564b0eb1d46209a48885d636e664643d4724b0fb188213',
     armv7l: 'bc29675fd4834f11e5564b0eb1d46209a48885d636e664643d4724b0fb188213',
       i686: 'b4f48444d69300ed14d5ab65de4f4607eae0c6ca6b6ba58750267bb4ce2516d2',
     x86_64: '25c593f216e86052f8eaf4ef9ce33c7e3a03382d7b08987a7f6eb1033a3845ae'
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
