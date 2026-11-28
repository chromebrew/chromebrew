require 'buildsystems/autotools'

class Ytnef < Autotools
  description "Yeraze's TNEF Stream Reader - for winmail.dat files."
  homepage 'https://github.com/Yeraze/ytnef'
  version '2.1.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Yeraze/ytnef.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bd641f48757535c0a7d355b969544ab6b042854f39558cdf0f3f016856b610b',
     armv7l: '8bd641f48757535c0a7d355b969544ab6b042854f39558cdf0f3f016856b610b',
       i686: 'ce706eb9ef804793910c8de1f80930a16d5fc41895a377d824a4801dc9142154',
     x86_64: 'f797ab0e8cbbd256b298122b601e6a971dadd8c36f30c83b2299b90689ececb9'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
