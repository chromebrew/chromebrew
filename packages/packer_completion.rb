require 'package'

class Packer_completion < Package
  description 'Add bash autocompletion for packer.'
  homepage 'https://github.com/mrolli/packer-bash-completion'
  version '1.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mrolli/packer-bash-completion/archive/1.0.0.tar.gz'
  source_sha256 '20ebfacd3f3a60f8dbd09e25b97d3b6e5049cbdf00a2d607fe79eaaef39e1eea'

  def self.install
    system "install -Dm644 packer #{CREW_PREFIX}/share/packer-bash-completion/packer"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Packer bash completion
      source #{CREW_PREFIX}/share/packer-bash-completion/packer
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/packer_completion", @env)
  end
end
