require 'package'

class Packer_completion < Package
  description 'Add bash autocompletion for packer.'
  homepage 'https://github.com/mrolli/packer-bash-completion'
  version '1.0.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mrolli/packer-bash-completion/archive/refs/tags/1.4.3.tar.gz'
  source_sha256 'af7b3b49b29ffdb05b519dad2d83066f3d166dd8e29abd406ca0f3d480901df4'

  def self.install
    FileUtils.mkdir "#{CREW_PREFIX}/share/packer-bash-completion/"
    FileUtils.install 'packer', "#{CREW_PREFIX}/share/packer-bash-completion/packer", mode: 644, verbose: true

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Packer bash completion
      source #{CREW_PREFIX}/share/packer-bash-completion/packer
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/packer_completion", @env)
  end
end
