require 'buildsystems/cmake'

class Cjson < CMake
  description 'Ultralightweight JSON parser in ANSI C'
  homepage 'https://github.com/DaveGamble/cJSON'
  version '1.7.19'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/DaveGamble/cJSON.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7bf01bc69417a6e04653c85cd2e499459e1b3278b75bf0bcc3a420816a1f1a5',
     armv7l: 'b7bf01bc69417a6e04653c85cd2e499459e1b3278b75bf0bcc3a420816a1f1a5',
       i686: '966bf049dfa73e39047efc27da6ff06092b2a3b3452cf12aaa06b90eaed965b4',
     x86_64: '018f1cff5176ac884fe5a359a9168e1e13bd6c444b3d44e47ce22e990478c243'
  })

  depends_on 'glibc' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DBUILD_SHARED_LIBS=ON'
end
