require 'buildsystems/autotools'

class Libcap_ng < Autotools
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng/'
  version "0.8.5-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03157fb9edeed725ed6cd8162731ae8ead0a5ad7841d783e9eb59a2aa1e0cab7',
     armv7l: '03157fb9edeed725ed6cd8162731ae8ead0a5ad7841d783e9eb59a2aa1e0cab7',
       i686: '9a2aa76e781b91013633d025504083d410110338057bb1ee485228bf68cd6ed6',
     x86_64: 'efe0c88308b8fe7b21ea87854cf562df5ef42b40b3a1da2d63d9b49214afbf8f'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  autotools_configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
