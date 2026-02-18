require 'buildsystems/autotools'

class Libcap_ng < Autotools
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng/'
  version "0.9.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '353196518b921cc15739c1986471ee2354346f117d2c59811b0dc3701b332428',
     armv7l: '353196518b921cc15739c1986471ee2354346f117d2c59811b0dc3701b332428',
       i686: '82d75a7d3e82df7a73f10a33eb38792bde58ace4a994080f7f2126da9c7b26de',
     x86_64: '3679b06d4b938cb6d513f2dde073a4068b140e1da07eb95a8980243a0095c3f4'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  autotools_configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
