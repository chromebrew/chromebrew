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
    aarch64: '206ebd9a75d31527d8e3a7cc2ae7dc0446e9958d4405b392e7c354704432736f',
     armv7l: '206ebd9a75d31527d8e3a7cc2ae7dc0446e9958d4405b392e7c354704432736f',
       i686: 'a8715960cc59ea05a1adde7a36ee256834e8514e2ab0a251ebd0413a304bf20f',
     x86_64: '70f938255289e933ebf61cd08096986b31f25d89d5a3d00829ac45248890bc64'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
