require 'buildsystems/autotools'

class Lzip < Autotools
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.26'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/lzip/lzip-#{version}.tar.gz"
  source_sha256 '641cf30961525cbe3b340cc883436c8854e9f5032f459f444de4782b621e6572'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11ad7fce088da6b2878e4dc871722b801016664e476725b51faf1dfdbb822dc2',
     armv7l: '11ad7fce088da6b2878e4dc871722b801016664e476725b51faf1dfdbb822dc2',
       i686: 'b76a19f8912f0aa5a28a4b6a023d658135987eeb1ae823ca37f9c50be604591a',
     x86_64: 'b5e130db332f424bf4297e0dcee8df1af2c96a437d7122b8be730fe7f7cd5db5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
end
