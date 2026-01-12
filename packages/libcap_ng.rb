require 'buildsystems/autotools'

class Libcap_ng < Autotools
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng/'
  version "0.9-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43d82a1c799067fe240ffd71ab8fc8ae7805c3a2ca7621e810826dde16e52585',
     armv7l: '43d82a1c799067fe240ffd71ab8fc8ae7805c3a2ca7621e810826dde16e52585',
       i686: '2b13fee449218031ab2fc4dde2f4a441a7a3e2b71a12f7e350e508a6d27023a8',
     x86_64: 'e112dc7b88f7a66c9586121f5852f14914f5b5a9ff4cf25e1c93428be2646bee'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  autotools_configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
