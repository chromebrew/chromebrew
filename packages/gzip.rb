require 'buildsystems/autotools'

class Gzip < Autotools
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.14'
  compatibility 'all'
  license 'GPL-3'
  source_url "https://ftpmirror.gnu.org/gzip/gzip-#{version}.tar.xz"
  source_sha256 '7454eb6935db17c6655576c2e1b0fabefd38b4d0936e0f87f48cd062ce91a057'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cc05d25a34eb5a7d26b3aded51d97ef80edc37fad21fad41888ddb774190b4a',
     armv7l: '4cc05d25a34eb5a7d26b3aded51d97ef80edc37fad21fad41888ddb774190b4a',
       i686: 'f3b6c28a23474b435d3b9479af4f003e50a873bd599b8ec5cba2b1e582b90936',
     x86_64: '5b2d9a48456d3aca4c07f778d4562ce86afdb8cf37eb333e1a1340c180b399b2'
  })

  depends_on 'glibc' # R

  run_tests
end
