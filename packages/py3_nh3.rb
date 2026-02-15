# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bbbac14b9dda0aa35191d175e2d1ce6ed630cd3ebd0fafb33d95fec338ad139',
     armv7l: '5bbbac14b9dda0aa35191d175e2d1ce6ed630cd3ebd0fafb33d95fec338ad139',
       i686: '328af9636d9df16bb15aea583ff54804f26207b3287ed9a47ec529598ed541a8',
     x86_64: '7e647956f0c5117e12e64cf83365dd680308b688ee8a6dfd56959ee1dd849e0c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
