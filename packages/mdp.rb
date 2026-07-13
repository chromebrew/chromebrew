require 'buildsystems/autotools'

class Mdp < Autotools
  description 'A command-line based markdown presentation tool.'
  homepage 'https://github.com/visit1985/mdp'
  version '1.0.18'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/visit1985/mdp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e30487f9e37ebc8c5bddc17815e2796789cdfb8a437ef1c4799ed463294f839',
     armv7l: '4e30487f9e37ebc8c5bddc17815e2796789cdfb8a437ef1c4799ed463294f839',
       i686: '22b69eb6d4c62a90c545ad0cebd782a82e1a679241364c0ddf42f0aedac53396',
     x86_64: '8327b998aae1a770f5debfe963389613bef1496650cc5516963bf503ab1a439b'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_skip_configure
  autotools_pre_make_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
