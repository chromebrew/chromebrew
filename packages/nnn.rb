require 'package'

class Nnn < Package
  description 'Full-featured terminal file manager.'
  homepage 'https://github.com/jarun/nnn'
  version '5.1'
  license 'BSD-2 Clause'
  compatibility 'all'
  source_url 'https://github.com/jarun/nnn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '000ba1399d70d6c9de8950cfe53b4d2f42c57d3b95262f85a8b44f8be8b28d4c',
     armv7l: '000ba1399d70d6c9de8950cfe53b4d2f42c57d3b95262f85a8b44f8be8b28d4c',
       i686: '17ed25fdf556d13f1665460b45175a764692864f9e67e56bff6be3a4330cfd1c',
     x86_64: 'd1d9634870b1a13101a6832ae34d8be09c434e3550594d9cdfde5f738760103d'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'pkg_config' => :build
  depends_on 'readline' # R

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
