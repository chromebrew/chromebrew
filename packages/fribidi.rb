require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://github.com/fribidi/fribidi/archive/v1.0.10.tar.gz'
  source_sha256 '3ebb19c4184ed6dc324d2e291d7465bc6108a20be019f053f33228e07e879c4f'


  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Ddocs=false -Dtests=false build"
    system 'meson configure build'
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
