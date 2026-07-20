require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version "0.4234-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4234.tar.gz'
  source_sha256 '66aeac6127418be5e471ead3744648c766bd01482825c5b66652675f2bc86a8f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8957aaf3a9b26a3e0f5918102d96c5b44c9d2e99ad803d02451a46256f5c01b9',
     armv7l: '8957aaf3a9b26a3e0f5918102d96c5b44c9d2e99ad803d02451a46256f5c01b9',
       i686: 'e205237b694760bdca1f2f950efdc6bf0f4e98744e6ebd88cdfacf2ff15fb827',
     x86_64: '7b92a666abd1885f6f2c40c5565a8e75a986180d4ef1292237277e48a7e089e1'
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
