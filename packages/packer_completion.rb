require 'package'

class Packer_completion < Package
  description 'Add bash autocompletion for packer.'
  homepage 'https://github.com/mrolli/packer-bash-completion'
  version '1.0.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mrolli/packer-bash-completion/archive/refs/tags/1.4.3.tar.gz'
  source_sha256 'af7b3b49b29ffdb05b519dad2d83066f3d166dd8e29abd406ca0f3d480901df4'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/packer_completion/1.0.0-1_armv7l/packer_completion-1.0.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/packer_completion/1.0.0-1_armv7l/packer_completion-1.0.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/packer_completion/1.0.0-1_i686/packer_completion-1.0.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/packer_completion/1.0.0-1_x86_64/packer_completion-1.0.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f5b7d5298e8d26c88409399074af9d00335dc7e30ba521fb9f413043324885a7',
     armv7l: 'f5b7d5298e8d26c88409399074af9d00335dc7e30ba521fb9f413043324885a7',
       i686: '07c51b5dfbd4b38b75fcfabacdd2d1dbcfc71d4ad5bdc3284b3b685707e750c7',
     x86_64: '44a68bde192c65ed695b496815dce5b09b826973a25100fd6262eb69144b884a'
  })

  def self.install
    FileUtils.mkdir "#{CREW_PREFIX}/share/packer-bash-completion/"
    FileUtils.install 'packer', "#{CREW_PREFIX}/share/packer-bash-completion/packer", mode: 644, verbose: true

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Packer bash completion
      source #{CREW_PREFIX}/share/packer-bash-completion/packer
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/packer_completion", @env)
  end
end
