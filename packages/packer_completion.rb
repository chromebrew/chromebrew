require 'package'

class Packer_completion < Package
  description 'Add bash autocompletion for packer.'
  homepage 'https://github.com/mrolli/packer-bash-completion'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://github.com/mrolli/packer-bash-completion/archive/1.0.0.tar.gz'
  source_sha256 '20ebfacd3f3a60f8dbd09e25b97d3b6e5049cbdf00a2d607fe79eaaef39e1eea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/packer_completion-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/packer_completion-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/packer_completion-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/packer_completion-1.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9334ea5ec25ee0207576ad8064e7d05bb3f7d56e38e788443992ee646f00eee7',
     armv7l: '9334ea5ec25ee0207576ad8064e7d05bb3f7d56e38e788443992ee646f00eee7',
       i686: 'ffe610cfa7cc113af4f2a6ec505aa2897aae771b0a3069b659fa53ae24aba902',
     x86_64: '72db1d2343fc28baaaef56b8aaca87442b3d713f99ca3e3889b920a816f2c4b2',
  })

  def self.install
    system "install -Dm644 packer #{CREW_PREFIX}/share/packer-bash-completion/packer"
  end

  def self.postinstall
    puts
    puts "To complete installation, execute the following:".lightblue
    puts "echo '# packer completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/packer-bash-completion/packer ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/packer-bash-completion/packer' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
