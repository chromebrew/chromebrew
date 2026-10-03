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
    aarch64: '60a57bd00ced100d4e8da6ce3e468dcd023a855dd81d6795ccbf9c6045e8323b',
     armv7l: '60a57bd00ced100d4e8da6ce3e468dcd023a855dd81d6795ccbf9c6045e8323b',
       i686: '998cb11793034ef6c936cafc0a44c5832d74779a875b73567d0ab2fa6304752b',
     x86_64: '85daa8b02791fb1e7f9c90cad0569b7595906fafd24b4085bdb463d79b0884db'
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
