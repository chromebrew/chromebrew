require 'buildsystems/autotools'

class Bash_completion < Autotools
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.18.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '244347bcaa7ada008bde73de29e1d7c87b891396f6c97ad0b548686cafcc185d',
     armv7l: '244347bcaa7ada008bde73de29e1d7c87b891396f6c97ad0b548686cafcc185d',
       i686: '1a54d7be53043f8fb99166a8128485913d62346c4e309907fd32e2639627e7d0',
     x86_64: '744c714d2b06c589c895f7c4fd696ca67fd282598f7ffa3f7416bdcbb8b15425'
  })

  depends_on 'bash' => :logical
end
