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
    aarch64: '450fd5c206d4593b7760080f24e8a44483521427812a60463d1695b7eef8b674',
     armv7l: '450fd5c206d4593b7760080f24e8a44483521427812a60463d1695b7eef8b674',
       i686: 'ab7d0298bbc60a1f50d13ebca645a13e3b0b4e2a43f84436a126e9082ea43af2',
     x86_64: '70f938255289e933ebf61cd08096986b31f25d89d5a3d00829ac45248890bc64'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
