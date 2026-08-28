require 'buildsystems/autotools'

class Yara < Autotools
  description 'The pattern matching swiss knife for malware researchers (and everyone else).'
  homepage 'https://virustotal.github.io/yara/'
  version '4.5.8'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/VirusTotal/yara.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4be8fac6c81b03ad01bc006e702b9e9c0ae1cd0b499b8cfdeee43eb0d77cb37',
     armv7l: 'a4be8fac6c81b03ad01bc006e702b9e9c0ae1cd0b499b8cfdeee43eb0d77cb37',
       i686: '6361816f374607d92d8420ed38f85a654ec8351dcdabaf7e94dd3666bc083ea3',
     x86_64: 'e7a67ae29395bbb788c3ee55831517cd116bb60964d22753a694e601310ee772'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library

  autotools_pre_configure_options 'YACC=bison'

  run_tests
end
