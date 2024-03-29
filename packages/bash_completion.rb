require 'buildsystems/autotools'

class Bash_completion < Autotools
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.12.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aae12d4f233a342bbc17695221f8398bc7ccc23945533782816a6ad562acc4c3',
     armv7l: 'aae12d4f233a342bbc17695221f8398bc7ccc23945533782816a6ad562acc4c3',
       i686: '8134858d86d86ed6ff327c8f36368533a66c29665c4266821b882c9eb8e974c4',
     x86_64: 'ead9142a41cc77b373a313c64a3a7e4e4f5da17cdda2cf8767efdbdc30a9c8b9'
  })
end
