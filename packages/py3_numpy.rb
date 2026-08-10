require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.5.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c15a9d2c8ea39bbefb5e9a032fe384d3e5a30b22058c929967c3e2184416e6aa',
     armv7l: 'c15a9d2c8ea39bbefb5e9a032fe384d3e5a30b22058c929967c3e2184416e6aa',
       i686: '2605e70d4fb96ccf87b525ff17aee5181681fe36839c7b0800febb2d093b1db5',
     x86_64: '1984b162c5dfb3e7445438f5e39ee528fab7776ec10130bfb25f148ecd5d1db3'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lapack' => :library
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
