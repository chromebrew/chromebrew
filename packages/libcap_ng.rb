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
    aarch64: 'cba7da554db69c2c928ec1dc97329a7b6116955a8d23ff05540ba436bf738fb2',
     armv7l: 'cba7da554db69c2c928ec1dc97329a7b6116955a8d23ff05540ba436bf738fb2',
       i686: '0ee69cc9da3dae1c502c5d74557cec31ee321017b75e4c574d2d31758f592e23',
     x86_64: '2059ede3b18680b4c04640908b50807cac169742bf3f27a67d5549f1e651150e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  autotools_configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
