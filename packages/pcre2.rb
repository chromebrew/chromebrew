require 'buildsystems/cmake'

class Pcre2 < CMake
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.47-1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2.git'
  git_hashtag "pcre2-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50bce7a8074feea90a002497dc5fb37f309becbc545fdc14ba18232f949c6c14',
     armv7l: '50bce7a8074feea90a002497dc5fb37f309becbc545fdc14ba18232f949c6c14',
       i686: 'e01a8475d9598dd01b11d06f7cd274ab419a98e107bee2ae56382d8cd933b43a',
     x86_64: '0684ca6b8a488696d594cc0874721fae0d8314eb59b0956709ce2e9b1233cab9'
  })

  depends_on 'bzip2' => :executable_only
  depends_on 'glibc' # R
  depends_on 'zlib' => :executable_only

  cmake_options '-DPCRE2_BUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DPCRE2_SUPPORT_JIT=ON \
      -DPCRE2_STATIC_PIC=ON \
      -DPCRE2_BUILD_PCRE2_16=ON \
      -DPCRE2_BUILD_PCRE2_32=ON'
end
