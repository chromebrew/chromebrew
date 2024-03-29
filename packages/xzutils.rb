require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.6.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version}"
  source_sha256 'f334777310ca3ae9ba07206d78ed286a655aa3f44eec27854f740c26b2cd2ed0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eef32693337bd3345001a1cd8d49b96940d5f9100916080a352abfe1a09de99f',
     armv7l: 'eef32693337bd3345001a1cd8d49b96940d5f9100916080a352abfe1a09de99f',
       i686: 'f9aaefa142d5c826e862b4a2ce627c9b5795a3fc744a58b01172416e0f1405e3',
     x86_64: 'c3fed03eafd462bd132bb945ae83adda4fada304654d971f3428943556fe3c23'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
