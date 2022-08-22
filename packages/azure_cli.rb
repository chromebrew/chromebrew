require 'package'

class Azure_cli < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.21.0'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'https://github.com/Azure/azure-cli/archive/refs/tags/azure-cli-2.21.0.tar.gz'
  source_sha256 'bbe4a1f85418d239444717f2c9706a87f81fd2515bb0bb4b4e48548fd3e08caa'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/azure_cli/2.21.0_i686/azure_cli-2.21.0-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/azure_cli/2.21.0_x86_64/azure_cli-2.21.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: '222e74caa74df6ab129f33f90aea86e65d000ebc4f5d78cb7f3ec2f98421ed3c',
    x86_64: '073b64f7104e298205afe623588c95f2e0cb17e664e53ff46042c9bd4076d2c8'
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I azure-cli==#{version} --no-warn-script-location"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/az"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @azureenv = <<~AZUREEOF
      # Microsoft Azure CLI bash completion
      source #{CREW_PREFIX}/share/azure-cli/az.completion
    AZUREEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/az", @azureenv)
  end
end
