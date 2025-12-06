require 'buildsystems/autotools'

class Ctags < Autotools
  description 'Universal Ctags generates an index file of language objects found in source files.'
  homepage 'https://ctags.io/'
  version '6.2.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/universal-ctags/ctags.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a61e18a2ce2b784d5964cd252a085eb43eb1e072be3742a64447952af611ff29',
     armv7l: 'a61e18a2ce2b784d5964cd252a085eb43eb1e072be3742a64447952af611ff29',
       i686: '8f6007cee791fdccb8f343275e7c334221973a43185df6c8bb5c822c00d70b7c',
     x86_64: '49de0cff6ff0c335ee581c3beeaae667cf6f86966e326543233a84991959c0d6'
  })

  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libseccomp' # R
  depends_on 'libxml2' # R
  depends_on 'libyaml' # R
  depends_on 'pcre2' # R
  depends_on 'py3_docutils' => :build
end
