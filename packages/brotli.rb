require 'buildsystems/cmake'

class Brotli < CMake
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.2.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83fd6ddf7bbe71349a2889d988eeaa2625997bc2cca245f6df7732ce51dcf929',
     armv7l: '83fd6ddf7bbe71349a2889d988eeaa2625997bc2cca245f6df7732ce51dcf929',
       i686: '766c0c07ff58427ccc66e213eb45874fad7bd210f8847275a09063da74f7c259',
     x86_64: 'd8a76f422b8b6835845387cdf4444dfb1b3b8a943a8a79a47f882debe1c7a6df'
  })

  depends_on 'glibc' => :library
end
