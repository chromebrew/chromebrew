require 'buildsystems/autotools'

class Parted < Autotools
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted/'
  version '3.6-2'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/parted/parted-#{version.split('-').first}.tar.xz"
  source_sha256 '3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dec111ce508f4446d74dcbefa2e2ccb7c9424a8e651f4a75b0091ebc5cd0c45b',
     armv7l: 'dec111ce508f4446d74dcbefa2e2ccb7c9424a8e651f4a75b0091ebc5cd0c45b',
       i686: 'ed682917604cfd68e3acd47bb6a3441db47e8cea3f468245066cadc13662866a',
     x86_64: '6c90b4c01a6275e5f09438a80c7f973042834fb801bd18cbd6dade603a843a9f'
  })

  depends_on 'glibc' # R
  depends_on 'lvm2' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'util_linux' # R
end
