require 'package'

class Perl_gtk3 < Package
  description 'Perl interface to the 3.x series of the gtk+ toolkit'
  homepage 'https://metacpan.org/pod/Gtk3'
  version '0.038-perl5.38'
  license 'GPL 2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.038.tar.gz'
  source_sha256 '70dc4bf2aa74981c79e15fd298d998e05a92eba4811f1ad5c9f1f4de37737acc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ae67dd879f5cf7e7dd04463431df0b43b81321732d6ee4c8c846a2812fe87f6',
     armv7l: '7ae67dd879f5cf7e7dd04463431df0b43b81321732d6ee4c8c846a2812fe87f6',
     x86_64: '70f7723d9dd961d6ee0e3d48b691889f7df435952ee2dce6ffbfa12b38ef68ba'
  })

  depends_on 'gtk3' # R

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
