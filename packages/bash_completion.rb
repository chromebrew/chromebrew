require 'buildsystems/autotools'

class Bash_completion < Autotools
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.13.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89eada9fa2c7cefa756f84092b7263ad8bc0d847793cad334443e9929cfdb76d',
     armv7l: '89eada9fa2c7cefa756f84092b7263ad8bc0d847793cad334443e9929cfdb76d',
       i686: 'b687949c680d08cddd59c7e01d882db0f8006800dd01dcf38948d78fb9e30f25',
     x86_64: 'c8794d54d7e2d25c987cc1b5a50957eedac78a65965d0270e6d8aabadd61a710'
  })

  depends_on 'bash' # L
end
