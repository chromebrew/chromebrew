require 'buildsystems/autotools'

class Apr < Autotools
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/apache/apr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2df42317de3af08a190a770c3f55b9f9dc67e8752ae5846954becd6e5eed4ee',
     armv7l: 'e2df42317de3af08a190a770c3f55b9f9dc67e8752ae5846954becd6e5eed4ee',
       i686: 'd1e1979b17d2871bb6fd85bf580925970e8077d5f60591c2b121d714a26d0356',
     x86_64: '51f1dc7998ba0c62a34ec6061e0b53ee92c83bab1a878736c2385e314a9cf74c'
  })

  depends_on 'glibc' # R
  depends_on 'libxcrypt' # R
  depends_on 'util_linux' # R

  autotools_configure_options '--with-devrandom --without-sendfile --enable-layout=GNU'
end
