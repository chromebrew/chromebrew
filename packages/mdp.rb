require 'buildsystems/autotools'

class Mdp < Autotools
  description 'A command-line based markdown presentation tool.'
  homepage 'https://github.com/visit1985/mdp'
  version '1.0.19'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/visit1985/mdp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '544142370778a36e908ee76a362cbe8efe05bb041ce052fe388a81488f8fa5e3',
     armv7l: '544142370778a36e908ee76a362cbe8efe05bb041ce052fe388a81488f8fa5e3',
       i686: '8b36008afc91d7014aecb04b6ff25874573177c7909b00a50687171c5cc44bf8',
     x86_64: 'd39384dda4837dc72b392fd318d2dbed746dde5dd0cfeb9900ac79ed02e2eee3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_skip_configure
  autotools_pre_make_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
