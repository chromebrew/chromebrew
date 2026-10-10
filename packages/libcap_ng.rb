require 'buildsystems/autotools'

class Libcap_ng < Autotools
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng/'
  version "0.9.3-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77fe362f71577eec68490263a455bfa459dfc7be0d9b2b35242c0c425280af30',
     armv7l: '77fe362f71577eec68490263a455bfa459dfc7be0d9b2b35242c0c425280af30',
       i686: '237c273bf93ae6620bc4309152c1048a4bd97120d36ec69c4a1f47631b277a0c',
     x86_64: '6d72486f5258f1c2b1a0915fa82a8cd065dca971e1e109b0a074d113478871c0'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  autotools_configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
