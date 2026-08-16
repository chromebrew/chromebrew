require 'package'

class Nnn < Package
  description 'Full-featured terminal file manager.'
  homepage 'https://github.com/jarun/nnn'
  version '5.3'
  license 'BSD-2 Clause'
  compatibility 'all'
  source_url 'https://github.com/jarun/nnn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4b3bb56d262ab297593bf4fb6f4496798e64e7b8705862369f223c24148a0b5',
     armv7l: 'd4b3bb56d262ab297593bf4fb6f4496798e64e7b8705862369f223c24148a0b5',
       i686: 'e11e9874d264604d29855aac841baf38f96e74ea3431e274fc0b34d7ad68d5fb',
     x86_64: 'bdccc62b929c05f7d823a856a93b08c46add6fa5691639659e6d1835cf2d9656'
  })

  depends_on 'glibc' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pkg_config' => :build
  depends_on 'readline' => :executable

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
