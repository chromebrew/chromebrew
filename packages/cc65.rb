require 'buildsystems/autotools'

class Cc65 < Autotools
  description 'Complete cross development package for 65(C)02 systems'
  homepage 'https://cc65.github.io/'
  version 'e11fb5c'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/cc65/cc65.git'
  git_hashtag 'e11fb5c39371046ebe25485f984f644c5a0d65d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ad543c6852051c24025b5886c7ed99c5c3820754a98de6917da1f4f78b12fbb',
     armv7l: '9ad543c6852051c24025b5886c7ed99c5c3820754a98de6917da1f4f78b12fbb',
       i686: '6dff94d523d4822daa68a18c1c9e375da61fbb9d58682ddf983a6cdfd11300c9',
     x86_64: 'b1c029d4510fa5883fe9688cadb7bb5fccac95f2a8eb7be5d6f8386dc85ded27'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  no_fhs

  autotools_skip_configure
  autotools_pre_make_options 'PREFIX=.'
  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/cc65"
    FileUtils.install Dir['bin/*'], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.mv Dir['include/*'], "#{CREW_DEST_PREFIX}/include/cc65"
    FileUtils.mv 'cfg', CREW_DEST_PREFIX
  end
end
