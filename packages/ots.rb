require 'buildsystems/meson'

class Ots < Meson
  description 'Sanitizer for OpenType'
  homepage 'https://github.com/khaledhosny/ots'
  version '9.3.0'
  license 'BSD 3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/khaledhosny/ots.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d04bc484bc63b30233f4138668be78d83a953b1dfca565dc09124804e10b4c2',
     armv7l: '7d04bc484bc63b30233f4138668be78d83a953b1dfca565dc09124804e10b4c2',
     x86_64: 'cc78cac1449eb55232e9c8b8c8276ba0f700900d5c51d454a71f0c5ff45ba8b4'
  })

  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtest' => :build
  depends_on 'lz4' => :executable
  depends_on 'woff2' => :executable
  depends_on 'zlib' => :executable

  run_tests
end
