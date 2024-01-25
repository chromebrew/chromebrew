require 'buildsystems/perl'

class Perl_locale_gettext < PERL
  description 'Locale::gettext - message handling functions'
  homepage 'https://search.cpan.org/dist/Locale-gettext/'
  license 'GPL-1+ or Artistic'
  version '1.07-perl5.38.2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdee6940b15d1b616bb70ff90670e003b956370a708bfa3f8025bd428a7da2f5',
     armv7l: 'cdee6940b15d1b616bb70ff90670e003b956370a708bfa3f8025bd428a7da2f5',
       i686: 'b4641c2a74ba733c45e92dc76dd36b737aa2a0696f82f80e980916c1bb6cd7a1',
     x86_64: 'a00092bdf8dee85ca9ebac6a885a414e0b17ed64bb6b62c862f221a4659a3a04'
  })

  depends_on 'glibc' # R
end
