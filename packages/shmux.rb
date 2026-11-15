require 'buildsystems/autotools'

class Shmux < Autotools
  description 'shell multiplexor'
  homepage 'https://github.com/shmux/shmux'
  version '1.0.3'
  license 'shmux'
  compatibility 'all'
  source_url 'https://github.com/shmux/shmux.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1a6bb863879f194374339602a44ce89d69f88f5a7c20984b6aad2513fb13205',
     armv7l: 'f1a6bb863879f194374339602a44ce89d69f88f5a7c20984b6aad2513fb13205',
       i686: '010a0065b7df8e7cd32423370cdb08392ec9021df6f967d8514b3238fdb4aeb8',
     x86_64: '107999616941e30d95d756a54fa97dba3dc16d62c8298e50ff3ac47c79e871df'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pcre' => :executable

  autotools_pre_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
