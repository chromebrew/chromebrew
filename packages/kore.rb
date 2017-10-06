require 'package'

class Kore < Package
  description 'An easy to use, scalable and secure web application framework for writing web APIs in C. '
  homepage 'https://kore.io'
  version '2.0.0'
  source_url 'https://github.com/jorisvink/kore/archive/2.0.0-release.tar.gz'
  source_sha256 'e9573a3bd986bc7d91ce3fb8898cb542523d6ed274761281cea72a81963549c1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'openssl'

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    # make install step doesn't respect DESTDIR
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "install -m 555 kore #{CREW_DEST_PREFIX}/bin/kore"
    system "mkdir -p #{CREW_DEST_PREFIX}/include/kore"
    system "install -m 644 includes/*.h #{CREW_DEST_PREFIX}/include/kore"
  end
end
