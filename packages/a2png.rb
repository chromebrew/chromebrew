require 'package'

class A2png < Package
  description 'Converts plain ASCII text into PNG bitmap images.'
  homepage 'https://sourceforge.net/projects/a2png/'
  version '0.1.5'
  source_url 'https://sourceforge.net/projects/a2png/files/a2png/0.1.5/a2png-0.1.5.tar.bz2'
  source_sha256 'd3ae1c771f5180d93f35cded76d9bb4c4cc2023dbe65613e78add3eeb43f736b'

  depends_on 'cairo'

  def self.build
    system './configure --enable-cairo \
            --with-cairo-lib=/usr/local/lib \
            --with-cairo-include=/usr/local/include/cairo'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

