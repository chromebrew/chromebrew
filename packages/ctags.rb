require 'buildsystems/autotools'

class Ctags < Autotools
  description 'Universal Ctags generates an index file of language objects found in source files.'
  homepage 'https://ctags.io/'
  version '6.1.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/universal-ctags/ctags.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25ade8a25ecc9c3df295d8253cbe0b992e2cbf22b853a5568e7eb3d169997ca9',
     armv7l: '25ade8a25ecc9c3df295d8253cbe0b992e2cbf22b853a5568e7eb3d169997ca9',
       i686: '53333c0528670faa8e6f24b8f4235dc758edd61a5741d23d847b7600a12262d6',
     x86_64: '1d096ed3ee855030060da5f4ac2762255830a3efd22085d11546f777c52de2e2'
  })

  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libseccomp' # R
  depends_on 'libxml2' # R
  depends_on 'libyaml' # R
  depends_on 'pcre2' # R
  depends_on 'py3_docutils' => :build
end
