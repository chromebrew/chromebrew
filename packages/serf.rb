require 'buildsystems/cmake'

class Serf < CMake
  description 'The serf library is a high performance C-based HTTP client library built upon the Apache Portable Runtime (APR) library.'
  homepage 'https://serf.apache.org/'
  version '1.3.10-73f26fa'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/apache/serf'
  git_hashtag '73f26fab7baca09c5257ac1da725589a639a44de'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3a423e564770ede0c631bfa897fcf3dc890b3808d466cc95e668237e3e41597',
     armv7l: 'c3a423e564770ede0c631bfa897fcf3dc890b3808d466cc95e668237e3e41597',
       i686: 'cd18234dd3caeb58c75aecde0108d82b8a8acafcde76f7815cd442ab74f6cc7d',
     x86_64: '81b31326e3f01cb25840b6154bc1f66f9a5ee39f96ef9eff23dd9efcdc241161'
  })

  depends_on 'apr'
  depends_on 'apr_util'
  depends_on 'openssl'

  cmake_options "-DAPR_ROOT=#{CREW_PREFIX} -DAPRUtil_ROOT=#{CREW_PREFIX}"
end
