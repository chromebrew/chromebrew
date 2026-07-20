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
    aarch64: '2c4e9a7893777eca61ff781e8e49c3cc8f887168ae8a9663a03b92038e5917ef',
     armv7l: '2c4e9a7893777eca61ff781e8e49c3cc8f887168ae8a9663a03b92038e5917ef',
       i686: 'dbb90a17ee0c118f5b69bae88f442cc635ae25bac45c815a7331882d3d6d6af6',
     x86_64: 'b8618abe245e27ed6cfb62b2020aa07d5c043789e03a323a87bf1c23b8bd1945'
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
