require 'buildsystems/autotools'

class Lzip < Autotools
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.23-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.23.tar.gz'
  source_sha256 '4792c047ddf15ef29d55ba8e68a1a21e0cb7692d87ecdf7204419864582f280d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23-1_armv7l/lzip-1.23-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23-1_armv7l/lzip-1.23-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23-1_i686/lzip-1.23-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23-1_x86_64/lzip-1.23-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fd1b606e21609e6fe88154c7b782b703f5bcd112936443fa082cafe65aaf414d',
     armv7l: 'fd1b606e21609e6fe88154c7b782b703f5bcd112936443fa082cafe65aaf414d',
       i686: '90636b071c6940cbd6eb5bdbe8b4b6b3fdf74da101147aa5a120df66c9814743',
     x86_64: '099c6a35a5ab4318dac5c00c4239e4cf227b6b23d668cb4e23aae476c7d4d76c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
