require 'buildsystems/autotools'

class Httrack < Autotools
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.50.5'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://github.com/xroche/httrack/releases/download/#{version}/httrack-#{version}.tar.gz"
  source_sha256 '4a017e8311035ec02ee2947e14022a5f1291c86c7e67e98ee762c9486f0db39d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d3d28cc34de2ba846afd830b26f86617acbc213c72baff20ec5c9118a54efb3',
     armv7l: '1d3d28cc34de2ba846afd830b26f86617acbc213c72baff20ec5c9118a54efb3',
       i686: 'a65012b7a83a25781759cbc48658839e44f7c0e3aabe5c9864e0bdbf1f37749b',
     x86_64: 'fde2b9653b600c23c6051cce7f918e8a33371045131631a14223897f1f2a1f3d'
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
