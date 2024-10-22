require 'buildsystems/autotools'

class Bash_completion < Autotools
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.14.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abe446ec4642cc6c715b76e8532384ce420b827665686484f7fa1068a89a9874',
     armv7l: 'abe446ec4642cc6c715b76e8532384ce420b827665686484f7fa1068a89a9874',
       i686: 'df4e80faf1ba0ecf75d6cf9206d546cd40b807970ff797d9bbdcb7edca024e0d',
     x86_64: 'b27e14ecdaff9a705fbb077d11e77b4a8ade88862d1493b02cae780ba9451b3e'
  })

  depends_on 'bash' # L
end
