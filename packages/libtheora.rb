require 'buildsystems/autotools'

class Libtheora < Autotools
  description 'Theora is a free and open video compression format from the Xiph.org Foundation.'
  homepage 'https://theora.org/'
  version '1.2.0'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xiph.org/xiph/theora.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd23420be72f47ce81a228bcaf3c3a0a2d14e9066e61b11bd866b583946000f2',
     armv7l: 'fd23420be72f47ce81a228bcaf3c3a0a2d14e9066e61b11bd866b583946000f2',
     x86_64: '67f6f01c91e6028ae23c58f36e8867d966c6d10d1f856f97e8801b6064c20184'
  })

  depends_on 'glibc' # R
  depends_on 'libogg'

  def self.patch
    system "sed -i 's|/usr/bin/perl|#{CREW_PREFIX}/bin/perl|' ./lib/arm/arm2gnu.pl"
  end

  run_tests
end
