require 'buildsystems/autotools'

class Hwloc < Autotools
  description 'Portable Hardware Locality is a portable abstraction of hierarchical architectures'
  homepage 'https://www.open-mpi.org/projects/hwloc/'
  version '2.13.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/open-mpi/hwloc.git'
  git_hashtag "hwloc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cab06f06a67122e3c522791127679ee898e89dbdac844ff493f3b8fcd34a1444',
     armv7l: 'cab06f06a67122e3c522791127679ee898e89dbdac844ff493f3b8fcd34a1444',
       i686: '1c845fa9919d78bfac9c830df2d491d3ef70aa2b8c2b22a9f616d87e83440968',
     x86_64: '8c17c555745128009ab14bebae97798ca6804ac45b2946834820aa33d50fdbc4'
  })

  depends_on 'eudev' # R
  depends_on 'glibc' # R
  depends_on 'libpciaccess' # R
  depends_on 'libxml2' # R
  depends_on 'pciutils' => :build

  autotools_configure_options '--disable-cairo --enable-plugins'
end
