require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.1-2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cef7b6df2ba1728b248c381f56a4470bc5be92ec2c0157b2a36326cd54e9a3b3',
     armv7l: 'cef7b6df2ba1728b248c381f56a4470bc5be92ec2c0157b2a36326cd54e9a3b3',
       i686: '6ec959488f90d26917af4febe7cbcd83d45ccff5bf7538039a46e6f2a38a0c10',
     x86_64: '179b01283ba1bc429bb8a76ffb291aa0f758dbeb308ad7e6a774211229c49e9a'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick wants a libtool file.
    ConvenienceFunctions.libtoolize('liblzma') unless ARCH.include?('i686')
  end
end
