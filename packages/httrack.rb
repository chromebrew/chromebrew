require 'buildsystems/autotools'

class Httrack < Autotools
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.50.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://github.com/xroche/httrack/releases/download/#{version}/httrack-#{version}.tar.gz"
  source_sha256 '644d4ec0e48ad596dacd7f8017b68d8a3f1dfc140284b412b53086e7d1664e9d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b51542d66c07433645adec5dcbbb590627f631871254ad2e144011c0283ff05c',
     armv7l: 'b51542d66c07433645adec5dcbbb590627f631871254ad2e144011c0283ff05c',
       i686: '0e19188cfa3b32583915d0cf0529e2fd5a8c5cc0bb6c78c130ca3d4a49a44036',
     x86_64: '0a79c76afbd4c1839fb30f76f314427ee59cc642ee9da8b02a12557008dc865c'
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
