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
    aarch64: 'a40e34470880b4da07313cff19db30477390ee2366dfa1cb9be871fc020d1ad0',
     armv7l: 'a40e34470880b4da07313cff19db30477390ee2366dfa1cb9be871fc020d1ad0',
       i686: '48b229dd5f9ebc03fc4885788edf7de8376e4fd48f5181acb87e2dde2e4549e5',
     x86_64: '87d00ea9fb8aa7f52e1153b84ebfb43c0d04356569287822b298656970242717'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
