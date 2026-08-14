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
    aarch64: '25f779ac3896cd66c34bea1830c5639392c4e33d28e55884698ecf6b79709124',
     armv7l: '25f779ac3896cd66c34bea1830c5639392c4e33d28e55884698ecf6b79709124',
       i686: '7e4d6f38e28400ff3ff17897ca2b83a5fc380e9bbce1cd2c53785ea2234a9c62',
     x86_64: '123dc2a644005e0322c744edaf0330e9b5de1a4f59102105bca8bdd2086835f5'
  })

  depends_on 'bash' => :logical
end
