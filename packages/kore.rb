require 'package'

class Kore < Package
  description 'An easy to use, scalable and secure web application framework for writing web APIs in C. '
  homepage 'https://kore.io'
  version '2.0.0'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/jorisvink/kore/archive/2.0.0-release.tar.gz'
  source_sha256 'e9573a3bd986bc7d91ce3fb8898cb542523d6ed274761281cea72a81963549c1'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kore/2.0.0_armv7l/kore-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kore/2.0.0_armv7l/kore-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kore/2.0.0_i686/kore-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kore/2.0.0_x86_64/kore-2.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '512d28966ca1e1799ff068f7a731eea315f3adc02377ea929488d65d010373ab',
     armv7l: '512d28966ca1e1799ff068f7a731eea315f3adc02377ea929488d65d010373ab',
       i686: 'bf8482fd7c6e51a32d1ce46a711f5eb91896291a25199be474a07c9401300a1c',
     x86_64: '5cbfea9a2817599e3ed083d43c8dc94c4a883b886dd8e8f167ac1623bb35baa0'
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
