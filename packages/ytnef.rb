require 'buildsystems/autotools'

class Ytnef < Autotools
  description "Yeraze's TNEF Stream Reader - for winmail.dat files."
  homepage 'https://github.com/Yeraze/ytnef'
  version '2.1.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Yeraze/ytnef.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '172a4f0459a6b9df5380ac706ead1573aae79cbb1f8697b19e6f1acc6026646a',
     armv7l: '172a4f0459a6b9df5380ac706ead1573aae79cbb1f8697b19e6f1acc6026646a',
       i686: '9692af769c5d203185a7c67c61d37de60157ff1378b4e2493c36cc27a55c6f57',
     x86_64: '4a50a58bbb8cbed4033d67bd7c699e0d1a1241cff102b78cc141717a5d562f6f'
  })
end
