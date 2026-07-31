require 'buildsystems/cmake'

class Librtlsdr < CMake
  description 'Software to turn the RTL2832U into an SDR'
  homepage 'https://github.com/steve-m/librtlsdr'
  version '2.0.2'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/steve-m/librtlsdr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe42fc632e5a7147c00c5ecdfc5800a121fb301d8cd0f543aa9f326dcc99ee11',
     armv7l: 'fe42fc632e5a7147c00c5ecdfc5800a121fb301d8cd0f543aa9f326dcc99ee11',
       i686: 'c8a20a15aeabf070a0841a016bd9e9b9512f06dc1a858510ceba955df5a977fc',
     x86_64: '1d914a604238d92cfd9ad003782a8859ae8981e185706f5376cf051c87bac628'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libusb' => :library
end
