require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.92.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a566eea8a3869de14315f10d9bbc896e62508a10e5c22e021252e59b89291ab9',
     armv7l: 'a566eea8a3869de14315f10d9bbc896e62508a10e5c22e021252e59b89291ab9',
       i686: 'e745b4b762fec886b71df2669f0c41d659c3c0ab61e7aa35074f0af1b6b3eab7',
     x86_64: '3ce0ffa49a44d08375eec7e9213415af941fd2447164d5fa33c19ae2665b4f2f'
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
