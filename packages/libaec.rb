require 'buildsystems/cmake'

class Libaec < CMake
  description 'Adaptive Entropy Coding library'
  homepage 'https://gitlab.dkrz.de/dkrz-sw/libaec'
  version '1.1.8'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url 'https://gitlab.dkrz.de/dkrz-sw/libaec.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82e435bd2e0f6efa3644d659abacb174b1aae7a5bf6366dc42e1c0d834bb16d0',
     armv7l: '82e435bd2e0f6efa3644d659abacb174b1aae7a5bf6366dc42e1c0d834bb16d0',
       i686: '8878c0e9826513fd4de014be2a9902b85c58e7752828611a207fa75f7aa1c0d8',
     x86_64: 'd78491c26bc92209fa11d86f57bcd7cd15e7812763fc0d50b739e76669d5cc96'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
