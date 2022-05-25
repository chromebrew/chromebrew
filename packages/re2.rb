require 'buildsystems/cmake'

class Re2 < CMake
  description 'RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python.'
  homepage 'https://github.com/google/re2/'
  version '2023-09-01'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/google/re2/archive/#{version}.tar.gz"
  source_sha256 '5bb6875ae1cd1e9fedde98018c346db7260655f86fdb8837e3075103acd3649b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2/2023-09-01_armv7l/re2-2023-09-01-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2/2023-09-01_armv7l/re2-2023-09-01-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2/2023-09-01_i686/re2-2023-09-01-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2/2023-09-01_x86_64/re2-2023-09-01-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2115d0d431c3d4c511a90c91b315cf7ba23f0a148fa9120d5f40a213c9ab5d79',
     armv7l: '2115d0d431c3d4c511a90c91b315cf7ba23f0a148fa9120d5f40a213c9ab5d79',
       i686: '2c0aff02b699216184d0370703fb9effcfce0a225541525ddab5aee942e2c585',
     x86_64: '14368932ce32c61012519b7bac70d4c9ba75a2bdcb33b33b277458b671197032'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
