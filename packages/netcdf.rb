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
    aarch64: 'a1149903b23b54f11c4aa13d829526d2c43c2732f41d468a492f118b87ae141a',
     armv7l: 'a1149903b23b54f11c4aa13d829526d2c43c2732f41d468a492f118b87ae141a',
       i686: 'ddc36823352654b843264736fe64f1e4d61d480cdb412c8e861743285c1072ae',
     x86_64: 'aa0a9fc30803bdd95618a27de63082dcd1c95e179e76f79eb64be4102b930318'
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
