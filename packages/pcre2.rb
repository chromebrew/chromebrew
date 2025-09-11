require 'buildsystems/cmake'

class Pcre2 < CMake
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.46'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2.git'
  git_hashtag "pcre2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca29704af73d52556b858ab61cb41d815185bee3726f441e04e9fee91628fc10',
     armv7l: 'ca29704af73d52556b858ab61cb41d815185bee3726f441e04e9fee91628fc10',
       i686: 'cb1afa9a9b11cf5f4b26443d16cddf0995b3b517da513592d8082b0666af9aa5',
     x86_64: 'cf2fd6458fc780eb92c2511933f66ba29607e91cca76f70894d16c9e3aa27368'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-DPCRE2_BUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DPCRE2_SUPPORT_JIT=ON \
      -DPCRE2_STATIC_PIC=ON \
      -DPCRE2_BUILD_PCRE2_16=ON \
      -DPCRE2_BUILD_PCRE2_32=ON'
end
