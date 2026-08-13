require 'buildsystems/cmake'

class Libfmt < CMake
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '12.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4b73379131808546d836d1d9ddd6bd289e3b833a7dc35bc218cb9380cea4b10',
     armv7l: 'f4b73379131808546d836d1d9ddd6bd289e3b833a7dc35bc218cb9380cea4b10',
       i686: '8a8f5209bd1938d7c86f05e2fed295c9e0a01cc7ae78ff63b7e66773fa58b270',
     x86_64: 'f441254cbbd0b0d2f28019aefefc426eccf63685ce2b09c73862eac483b6cc62'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=TRUE'
  run_tests

  def self.patch
    patches = [
      # Fix for i686 breakage mentioned in https://github.com/fmtlib/fmt/issues/4811
      ['https://github.com/fmtlib/fmt/pull/4813.patch', '423847f4e448361cae1d86a2ab62e47b3cd31b76a065294ff9b2e5a689ec9cbd']
    ]
    ConvenienceFunctions.patch(patches) if version.eql?('12.2.0')
  end
end
