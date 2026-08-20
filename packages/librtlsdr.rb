require 'buildsystems/cmake'

class Librtlsdr < CMake
  description 'Software to turn the RTL2832U into an SDR'
  homepage 'https://github.com/steve-m/librtlsdr'
  version '2.0.3'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/steve-m/librtlsdr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52047b6784c026f6602da79002b8968acbe9b1d2b3f359850439d05733edafa1',
     armv7l: '52047b6784c026f6602da79002b8968acbe9b1d2b3f359850439d05733edafa1',
       i686: '0ec7675a217a13ee1cc283f4546633d4a310564a7715c57ed74f9d2bb925f229',
     x86_64: 'cf549ae241d3aae0e03f4ececca72f3f8aa6e170160ad915625414b8c70a24bc'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libusb' => :library
end
