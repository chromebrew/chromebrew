require 'buildsystems/autotools'

class Osl < Autotools
  description 'OpenScop is a Specification and a Library for Data Exchange in Polyhedral Compilation Tools'
  homepage 'https://github.com/periscop/openscop'
  version '0.9.7'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/periscop/openscop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49a5e2ce4f59ea4d2b3140170d7f471214fb904400dd43d5b61c05f3cd52a9e9',
     armv7l: '49a5e2ce4f59ea4d2b3140170d7f471214fb904400dd43d5b61c05f3cd52a9e9',
       i686: '90a1a72a64481a75e3d3ef59c8440cefa211448e8366405bebf77f45be70fe33',
     x86_64: '28c92686aa94cc86be32477a597d15e03e245d023dab18aaf2395b805437bfa4'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R

  run_tests
end
