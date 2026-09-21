require 'buildsystems/autotools'

class Gzip < Autotools
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.15'
  compatibility 'all'
  license 'GPL-3'
  source_url "https://ftp.gnu.org/gnu/gzip/gzip-#{version}.tar.xz"
  source_sha256 '9aa0cc780dec156b8282844833b342ab7cb08c25d2cd9a1869cdd0df31deff48'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cc05d25a34eb5a7d26b3aded51d97ef80edc37fad21fad41888ddb774190b4a',
     armv7l: '4cc05d25a34eb5a7d26b3aded51d97ef80edc37fad21fad41888ddb774190b4a',
       i686: 'f3b6c28a23474b435d3b9479af4f003e50a873bd599b8ec5cba2b1e582b90936',
     x86_64: '5b2d9a48456d3aca4c07f778d4562ce86afdb8cf37eb333e1a1340c180b399b2'
  })

  depends_on 'glibc' => :executable

  no_filefix
  run_tests

  autotools_configure_options ('--disable-year2038' if ARCH == 'armv7l').to_s
end
