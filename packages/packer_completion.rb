require 'package'

class Packer_completion < Package
  description 'Add bash autocompletion for packer.'
  homepage 'https://github.com/mrolli/packer-bash-completion'
  version '1.0.0'
  source_url 'https://github.com/mrolli/packer-bash-completion/archive/1.0.0.tar.gz'
  source_sha256 '20ebfacd3f3a60f8dbd09e25b97d3b6e5049cbdf00a2d607fe79eaaef39e1eea'

  binary_url ({
  })
  binary_sha256 ({
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
