require 'buildsystems/cmake'

class Re2 < CMake
  description 'RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python.'
  homepage 'https://github.com/google/re2/'
  version '2025-11-05'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/google/re2/archive/#{version}.tar.gz"
  source_sha256 '87f6029d2f6de8aa023654240a03ada90e876ce9a4676e258dd01ea4c26ffd67'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f320d1720c8a11c0c056fa32d2eab84b6e0bd5acb38af28835134b6e13e6932',
     armv7l: '0f320d1720c8a11c0c056fa32d2eab84b6e0bd5acb38af28835134b6e13e6932',
       i686: 'be21ad7660d9d33cf173b1ec366d8b6a41c9d150bb6e2fe3e8b4f93eb4f43c0a',
     x86_64: '87d1931d3494c8c7b4607e337178705f04952b461ca561e38c7bbad22504476b'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
