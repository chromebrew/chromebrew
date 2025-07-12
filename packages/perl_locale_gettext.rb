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
    aarch64: 'ea2b381247d367fdf7c90a4114c7bd3b3d1fcf04131f74a25be9e78b7e9c89c2',
     armv7l: 'ea2b381247d367fdf7c90a4114c7bd3b3d1fcf04131f74a25be9e78b7e9c89c2',
       i686: '1d29f0e0166383af3eed1ce03f85ca280ce4a0cf75022b9e6036d2e688cdd7b9',
     x86_64: '1b1ef261df52b10d9f1c330d79961a38d293eaf48e791a6ed972a9f7785d3af8'
  })

  depends_on 'glibc' # R
end
