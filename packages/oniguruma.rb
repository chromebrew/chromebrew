require 'package'

class Oniguruma < Package
  description 'Oniguruma is a modern and flexible regular expressions library.'
  homepage 'https://github.com/kkos/oniguruma'
  version '6.9.3'
  source_url 'https://github.com/kkos/oniguruma/archive/v6.9.3.tar.gz'
  source_sha256 'dc6dec742941e24b761cea1b9a2f12e750879107ae69fd80ae1046459d4fb1db'

  binary_url ({
  })
  binary_sha256 ({
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
