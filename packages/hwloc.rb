require 'buildsystems/autotools'

class Hwloc < Autotools
  description 'Portable Hardware Locality is a portable abstraction of hierarchical architectures'
  homepage 'https://www.open-mpi.org/projects/hwloc/'
  version '2.14.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/open-mpi/hwloc.git'
  git_hashtag "hwloc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5af9b6e1e2caee9a6b63d1d2a432629026b038b89f97b6d46e5632feb33c9bf',
     armv7l: 'a5af9b6e1e2caee9a6b63d1d2a432629026b038b89f97b6d46e5632feb33c9bf',
       i686: 'be0b91f86a4b93f98e127c5f3006641b9a2279d1c2394b98f7defb7adf568777',
     x86_64: '3eb3704c328c7e28e04dd1be74922ecd4c485cc9324cd5e186be81929181e91b'
  })

  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'libpciaccess' => :library
  depends_on 'libxml2' => :library
  depends_on 'pciutils' => :build

  autotools_configure_options '--disable-cairo --enable-plugins'
end
