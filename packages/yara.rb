require 'buildsystems/autotools'

class Yara < Autotools
  description 'The pattern matching swiss knife for malware researchers (and everyone else).'
  homepage 'https://virustotal.github.io/yara/'
  version '4.6.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/VirusTotal/yara.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06cd2814399e204c98aafe0a4a66237798dd7fb85c87b1262bb58b3b9e193ea0',
     armv7l: '06cd2814399e204c98aafe0a4a66237798dd7fb85c87b1262bb58b3b9e193ea0',
       i686: '192484a8b7bc1fc1082ab00583ce3317f8d6b00b73c467a9f5a5ec8a8afb7244',
     x86_64: '24a01482507427b2c8fbc4b23f3d78d749c22472aac3821b4618e3dfa7a58f4e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library

  autotools_pre_configure_options 'YACC=bison'

  run_tests
end
