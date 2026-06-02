require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.87.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5064fbd648fae651ad274cfbc968233a4ccc31f33f6e07dd8ff0bdbd2fcf19f',
     armv7l: 'a5064fbd648fae651ad274cfbc968233a4ccc31f33f6e07dd8ff0bdbd2fcf19f',
       i686: 'c917eb3cd6595f33ec348bbe27f464e62b0e0c5707988556d0674deb9fb0abb4',
     x86_64: '24721ceeddded8f6696036baaa1d268491b4d7cf36ab961d425f8e0c0829783b'
  })

  depends_on 'py3_bcrypt'
  depends_on 'py3_cryptography'
  depends_on 'py3_pynacl'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
  print_source_bashrc

  pip_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @azureenv = <<~AZUREEOF
      # Microsoft Azure CLI bash completion
      source #{CREW_PREFIX}/bin/az.completion.sh
    AZUREEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/az", @azureenv)
  end
end
