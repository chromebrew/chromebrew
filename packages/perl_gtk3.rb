require 'package'

class Perl_gtk3 < Package
  description 'Perl interface to the 3.x series of the gtk+ toolkit'
  homepage 'https://metacpan.org/pod/Gtk3'
  version '0.038-perl5.36'
  license 'GPL 2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.038.tar.gz'
  source_sha256 '70dc4bf2aa74981c79e15fd298d998e05a92eba4811f1ad5c9f1f4de37737acc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gtk3/0.038-perl5.36_armv7l/perl_gtk3-0.038-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gtk3/0.038-perl5.36_armv7l/perl_gtk3-0.038-perl5.36-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gtk3/0.038-perl5.36_x86_64/perl_gtk3-0.038-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6b0a1b7156c6563cfdcf229ca009229276b35bfc8eeff0d336bb1656df3f4846',
     armv7l: '6b0a1b7156c6563cfdcf229ca009229276b35bfc8eeff0d336bb1656df3f4846',
     x86_64: '7e4e2cd7a197267e5f3efdc1579b81d0486142e86aba6feea5b0faac88f6a1d6'
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
