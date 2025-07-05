require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.org/'
  version '1.34.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55626b5146a5e0e520ce897c6bf57675eda290f764ec14f393a236828394ebd3',
     armv7l: '55626b5146a5e0e520ce897c6bf57675eda290f764ec14f393a236828394ebd3',
       i686: '2c5437af979961d57631a736b3dd940a0a1c9554526d9ed5c44485de80ca475a',
     x86_64: '91f0cab2f784da739341c4a5b725cc3197ea309b7c2a8010956d4fcb7fd891d6'
  })

  depends_on 'glibc' # R

  cmake_options '-DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON'
end
