require 'buildsystems/cmake'

class Libversion < CMake
  description 'Advanced version string comparison library.'
  homepage 'https://github.com/repology/libversion'
  version '3.0.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/repology/libversion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fb7fd997c1de9d3d567b80931b2bea977ad233d55f8a067bc93bbbd8f7b8e85',
     armv7l: '3fb7fd997c1de9d3d567b80931b2bea977ad233d55f8a067bc93bbbd8f7b8e85',
       i686: '63a3c352fa9a6c48199581dcaaa681efd323ad2fc5d643237ee34f7057acc819',
     x86_64: '28f8483402a4b9c465bd07fb2907c386ef2227441fbcd5fe505d0618fc42f626'
  })

  run_tests
end
