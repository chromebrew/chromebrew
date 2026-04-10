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
    aarch64: '60b87b152507693c26c35937658e92a3b7807582777fe3e4708dba33c0148119',
     armv7l: '60b87b152507693c26c35937658e92a3b7807582777fe3e4708dba33c0148119',
       i686: 'b1a5beec5bb2eff8bf6dd72ba4a1d16c979c37909a18169cf530c514970f531c',
     x86_64: '4859ca3a65257063fd0099966e136de4aa6858b6de9f2104214e3143e7856199'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  autotools_configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
