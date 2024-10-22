require 'package'

class Packer_completion < Package
  description 'Add bash autocompletion for packer.'
  homepage 'https://github.com/mrolli/packer-bash-completion'
  version '1.4.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mrolli/packer-bash-completion.git'
  git_hashtag version

  depends_on 'packer'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/share/packer-bash-completion/packer", mode: 644, verbose: true

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/packer_completion", <<~EOF
      # Packer bash completion
      source #{CREW_PREFIX}/share/packer-bash-completion/packer
    EOF
  end
end
