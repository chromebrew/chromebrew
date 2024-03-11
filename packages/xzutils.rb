require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.6.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz/releases/download/v5.6.1/xz-5.6.1.tar.xz'
  source_sha256 'f334777310ca3ae9ba07206d78ed286a655aa3f44eec27854f740c26b2cd2ed0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f0f0a9ae25fa21008a30f7de4fedfa3e3f2a56b390b4a6b8d42563b4cff8d71',
     armv7l: '3f0f0a9ae25fa21008a30f7de4fedfa3e3f2a56b390b4a6b8d42563b4cff8d71',
       i686: '8f18cc8c977455ffa5761fa46b121e6491d513b5a1dd172b52c8b45ff2d8153c',
     x86_64: '9387bd15ec6d123f6fff74795b26889410f7d58c06b89d9d58c93a2fd195085a'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON \
                 -DENABLE_SANDBOX=OFF'
end
