require 'buildsystems/autotools'

class Ltrace < Autotools
  description 'ltrace intercepts and records dynamic library calls which are called by an executed process and the signals received by that process.'
  homepage 'https://www.ltrace.org/'
  version '0.8.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.com/cespedes/ltrace.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'libunwind'
  depends_on 'procps'


  # TODO: waiting on https://gitlab.com/cespedes/ltrace/-/merge_requests/27
  # ngl im not making this a patch i can wait for this to be a clean release
  autotools_configure_options '--disable-werror --without-elfutils'
end
