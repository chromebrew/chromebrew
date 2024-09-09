require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version '2.13.1-icu75.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5604d4b56e4360e55ede348accc9c7f9c22e2ced2570cef9c3be1dfad59390f',
     armv7l: 'f5604d4b56e4360e55ede348accc9c7f9c22e2ced2570cef9c3be1dfad59390f',
       i686: '7efd3f6fb928f43567b34d888f733fe2ca1c80f6e9609a3b8bcd55379c6f9961',
     x86_64: '33f98e0f8ba4a385afe434a168042c0c2528ea43534345613873c1cb7c546730'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c' # R

  no_source_build
end
