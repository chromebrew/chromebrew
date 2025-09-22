# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7149fc23b4e5dec13bb397fa8235abd314ea6fdaa7770c5af4197443b4b9d0be',
     armv7l: '7149fc23b4e5dec13bb397fa8235abd314ea6fdaa7770c5af4197443b4b9d0be',
       i686: '42d2af23dce478812094564633b0c6cf575e1c21a9554672c2ff3569c39c34df',
     x86_64: 'c951cf65fc085abcd74ae2e001b7363be22fae63f5a1e81d98702afa7406ecc1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
