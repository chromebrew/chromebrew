require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '1.0.9'
  source_url 'https://github.com/fribidi/fribidi/releases/download/v1.0.9/fribidi-1.0.9.tar.xz'
  source_sha256 'c5e47ea9026fb60da1944da9888b4e0a18854a0e2410bbfe7ad90a054d36e0c7'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
