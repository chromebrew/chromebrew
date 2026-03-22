require 'buildsystems/cmake'

class Optipng < CMake
  description 'OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information.'
  homepage 'https://optipng.sourceforge.net/'
  version '7.9.1'
  license 'ZLIB'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-#{version}/optipng-#{version}.tar.gz"
  source_sha256 'c2579be58c2c66dae9d63154edcb3d427fef64cb00ec0aff079c9d156ec46f29'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b885d5e53bbe54ecae635c91bf8bdeb90aed187aa49d92e27153073ec2e866de',
     armv7l: 'b885d5e53bbe54ecae635c91bf8bdeb90aed187aa49d92e27153073ec2e866de',
       i686: '1ac0481618048c34f4893f05a4e3fb48854629a744ef1622d38a441b733940e9',
     x86_64: 'b3d2f6078e72506f171be7f8cf9ed0c9965c03bdfc8d1d7eaa5042876125913b'
  })

  depends_on 'glibc' => :executable
  depends_on 'libpng' => :executable
  depends_on 'zlib' => :executable

  cmake_options '-DOPTIPNG_USE_SYSTEM_ZLIB=ON -DOPTIPNG_USE_SYSTEM_PNG=ON' # Bundled libpng doesn't work on armv7l

  cmake_install_extras do
    FileUtils.chmod 0o755, "#{CREW_DEST_PREFIX}/bin/optipng"
  end

  run_tests
end
