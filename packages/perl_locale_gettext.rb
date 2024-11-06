require 'buildsystems/perl'

class Perl_locale_gettext < PERL
  description 'Locale::gettext - message handling functions'
  homepage 'https://search.cpan.org/dist/Locale-gettext/'
  license 'GPL-1+ or Artistic'
  version "1.07-#{CREW_PERL_VER}"
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ca917e03c8b1d2674104d88b6548f171d40df6ccc41c2c30a1292d143f270a8',
     armv7l: '2ca917e03c8b1d2674104d88b6548f171d40df6ccc41c2c30a1292d143f270a8',
       i686: 'b336745b81c70e9a4343467fcb33e367775515bd2748ecd7de17460efbc5b697',
     x86_64: 'b9ecdb71da92acf79c4851bc568bbc03d4f6faa3f4d2aac01a55d7d922156759'
  })

  depends_on 'glibc' # R
end
