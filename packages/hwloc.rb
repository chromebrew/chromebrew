require 'buildsystems/autotools'

class Hwloc < Autotools
  description 'Portable Hardware Locality is a portable abstraction of hierarchical architectures'
  homepage 'https://www.open-mpi.org/projects/hwloc/'
  version '2.12.2'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/open-mpi/hwloc.git'
  git_hashtag "hwloc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d8f78b18bcf6f90d795c2f430619c8aa41eb592796f35bf1121b72cfa96f825',
     armv7l: '7d8f78b18bcf6f90d795c2f430619c8aa41eb592796f35bf1121b72cfa96f825',
       i686: '829511bc563726fd616770ab823e70b3e5b616beccf19bfc0fa9c391d87676e3',
     x86_64: 'a196c04d6f1f817d8a42153cffbc14212888385756bdcfc682bc1c44a37cb116'
  })

  depends_on 'eudev' # R
  depends_on 'glibc' # R
  depends_on 'libpciaccess' # R
  depends_on 'libxml2' # R
  depends_on 'pciutils' => :build

  autotools_configure_options '--disable-cairo --enable-plugins'
end
