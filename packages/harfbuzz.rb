require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.4.7'
  source_url 'https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.4.7.tar.bz2'
  source_sha256 'b85f6627425d54f32118308e053b939c63a388de9bf455b3830f68cad406bc6d'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
