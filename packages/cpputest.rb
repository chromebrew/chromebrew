require 'buildsystems/autotools'

class Cpputest < Autotools
  description 'Unit testing and mocking framework for C/C++.'
  homepage 'https://cpputest.github.io/'
  version '4.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/cpputest/cpputest.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa4314cd8b49b794ecf062a7fa77e27a5aea1791a56f82a16bfbd5b39a1dda80',
     armv7l: 'fa4314cd8b49b794ecf062a7fa77e27a5aea1791a56f82a16bfbd5b39a1dda80',
       i686: '918d4f923bb72166b4cb5ec2cb54749c51e404f8d6476845542fad5100abf934',
     x86_64: 'c4530cc013f5ce90b7b96f9e5e0d4c5a7466b44cda3e2429f1a568bc4f02e5e8'
  })

  run_tests
end
