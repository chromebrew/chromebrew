require 'package'

class Libdca < Package
  description 'libdca is a free library for decoding DTS Coherent Acoustics streams.'
  homepage 'https://www.videolan.org/developers/libdca.html'
  version '0.0.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://get.videolan.org/libdca/0.0.7/libdca-0.0.7.tar.bz2'
  source_sha256 '3a0b13815f582c661d2388ffcabc2f1ea82f471783c400f765f2ec6c81065f6a'

  def self.build
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
