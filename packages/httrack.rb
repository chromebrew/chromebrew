require 'buildsystems/autotools'

class Httrack < Autotools
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.51.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://github.com/xroche/httrack/releases/download/#{version}/httrack-#{version}.tar.gz"
  source_sha256 '1daa7ec0153ec16e6bea809c2d8829ceddf0e06f74471fa0528ffbf20275f5f1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '216c486e6343875a8686922e8913b5c8680a234fd657e9c9c07dfb3064a08623',
     armv7l: '216c486e6343875a8686922e8913b5c8680a234fd657e9c9c07dfb3064a08623',
       i686: '1deb0fdb320b7b8aafadb3532699d4d75b2067836298126a1173e40b7a28e7e9',
     x86_64: 'daa48e711140ba043f2576ee96868ca116e1961b677fae74b8fbce4abe139121'
  })

  depends_on 'brotli' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_skip_autoreconf
  autotools_skip_bootstrap
end
