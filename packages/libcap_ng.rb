require 'buildsystems/autotools'

class Libcap_ng < Autotools
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng'
  version '0.8.4-py3.12'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag 'v0.8.4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa8f2961dfa0b0b65fbe825adb4d9e309a686d2d117dc1f5f85dc7f182c55097',
     armv7l: 'fa8f2961dfa0b0b65fbe825adb4d9e309a686d2d117dc1f5f85dc7f182c55097',
       i686: 'b185e87d42132d43967b16a19a57ed4ffca706900f7763916dc06230aeabf810',
     x86_64: '07de5585d76f4e0ee0b4e2ab5740189718b371edd5bad6ca18887136721c86f1'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  configure_options "--with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
end
