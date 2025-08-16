require 'buildsystems/cmake'

class Re2 < CMake
  description 'RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python.'
  homepage 'https://github.com/google/re2/'
  version '2025-08-12'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/google/re2/archive/#{version}.tar.gz"
  source_sha256 '5bb6875ae1cd1e9fedde98018c346db7260655f86fdb8837e3075103acd3649b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f672b27265d5d9122579f073be11d733928719b560cdcdcb7422f68919863e32',
     armv7l: 'f672b27265d5d9122579f073be11d733928719b560cdcdcb7422f68919863e32',
       i686: '093ebd749668386b27e647bd4bb2b9c8213e57418b255f225ffe9c3dfd02a471',
     x86_64: 'f510ca34c83a390418040f7047fbc9c16df5377f8d66260bc5efde9d3b7c12c9'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
