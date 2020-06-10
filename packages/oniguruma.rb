require 'package'

class Oniguruma < Package
  description 'Oniguruma is a modern and flexible regular expressions library.'
  homepage 'https://github.com/kkos/oniguruma'
  version '6.9.3'
  compatibility 'all'
  source_url 'https://github.com/kkos/oniguruma/archive/v6.9.3.tar.gz'
  source_sha256 'dc6dec742941e24b761cea1b9a2f12e750879107ae69fd80ae1046459d4fb1db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/oniguruma-6.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/oniguruma-6.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/oniguruma-6.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/oniguruma-6.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6235fcfb3eb95dddafe8979adca6a4ba1bfc47d2c802a8bc14b73f1f57a30f5',
     armv7l: 'b6235fcfb3eb95dddafe8979adca6a4ba1bfc47d2c802a8bc14b73f1f57a30f5',
       i686: '11d6178e2662c45b869e9f3c3335291f60c74623e33f8cb027f1cdc1b81ab686',
     x86_64: 'ba64baffe8cc1797ac44d7385d6d0c11d9438bfe9f11ece17f80a34740e32753',
  })

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
