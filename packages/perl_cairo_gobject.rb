require 'package'

class Perl_cairo_gobject < Package
  description 'Integrate Cairo into the Glib type system'
  homepage 'https://metacpan.org/pod/Cairo::GObject'
  version '1.005-perl5.36'
  license 'GPL 2.1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-GObject-1.005.tar.gz'
  source_sha256 '8d896444d71e1d0bca3d24e31e5d82bd0d9542aaed91d1fb7eab367bce675c50'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo_gobject/1.005-perl5.36_armv7l/perl_cairo_gobject-1.005-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo_gobject/1.005-perl5.36_armv7l/perl_cairo_gobject-1.005-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo_gobject/1.005-perl5.36_i686/perl_cairo_gobject-1.005-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo_gobject/1.005-perl5.36_x86_64/perl_cairo_gobject-1.005-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '33b9accb1fb2eb0aab252d918712161f33b50fcd5c5621b461dfaef31e2bf17d',
     armv7l: '33b9accb1fb2eb0aab252d918712161f33b50fcd5c5621b461dfaef31e2bf17d',
       i686: '0c711b4ae13f95d8d6f615123ccf4950962972af44e31b065c936df0db3822cb',
     x86_64: 'dcbad470531637c71cf35babd24d37cd7929d4b35019bc6451ea1deca3415c57'
  })

  depends_on 'perl_cairo' => :build
  depends_on 'perl_glib' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  no_compile_needed

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
