require 'buildsystems/cmake'

class Netcdf < CMake
  description 'NetCDF is a set of software libraries and self-describing, machine-independent data formats that support the creation, access, and sharing of array-oriented scientific data.'
  homepage 'https://www.unidata.ucar.edu/software/netcdf/'
  version '4.10.1'
  license 'UCAR-Unidata'
  compatibility 'all'
  source_url 'https://github.com/Unidata/netcdf-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0641f638f746a567866502a30d590403b4c7593f9555e695f81b80c2e28b0c85',
     armv7l: '0641f638f746a567866502a30d590403b4c7593f9555e695f81b80c2e28b0c85',
       i686: '43b70695d7fb64f8bea80adf1ad719473eb7065a767ca00de7d995a0101dc168',
     x86_64: '4471b03ef9097326169f569218ea380e81a226d66ccedbde765d2b7205f5e9fa'
  })

  depends_on 'bzip2' => :library
  depends_on 'curl' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hdf5' => :library
  depends_on 'libaec' => :library
  depends_on 'libxml2' => :library
  depends_on 'libzip' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library
end
