require 'package'

class Nnn < Package
  description 'Full-featured terminal file manager.'
  homepage 'https://github.com/jarun/nnn'
  version '5.2'
  license 'BSD-2 Clause'
  compatibility 'all'
  source_url 'https://github.com/jarun/nnn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd755c2cd4aefe85b5e07e9ce2250c089de54c5c4e403f85e796f27444826f395',
     armv7l: 'd755c2cd4aefe85b5e07e9ce2250c089de54c5c4e403f85e796f27444826f395',
       i686: '3c767e8ac94bb4b87694791306ceee3620962a5d221d7c4a92714fae049e47e5',
     x86_64: 'b6b21729a493ed1f515c81fc099ea798c8b671061b3d6c2638ff3e4bb0df860c'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'ncurses' => :executable_only
  depends_on 'pkg_config' => :build
  depends_on 'readline' => :executable_only

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
