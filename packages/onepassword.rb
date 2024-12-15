require 'package'

class Onepassword < Package
  description '1Password CLI brings 1Password to your terminal.'
  homepage 'https://1password.com/'
  version '2.30.3'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://cache.agilebits.com/dist/1P/op2/pkg/v#{version}/op_linux_arm_v#{version}.zip",
     armv7l: "https://cache.agilebits.com/dist/1P/op2/pkg/v#{version}/op_linux_arm_v#{version}.zip",
       i686: "https://cache.agilebits.com/dist/1P/op2/pkg/v#{version}/op_linux_386_v#{version}.zip",
     x86_64: "https://cache.agilebits.com/dist/1P/op2/pkg/v#{version}/op_linux_amd64_v#{version}.zip"
  })
  source_sha256({
    aarch64: '85fe42b4e053452b0c341b21e9c9c1a95ac18abe574b702e5feaa9516dd5ca01',
     armv7l: '85fe42b4e053452b0c341b21e9c9c1a95ac18abe574b702e5feaa9516dd5ca01',
       i686: '4248635293f79bb19065600fd8a4077512c1ac806e804e837cad9be181469b50',
     x86_64: 'a16307ebcecb40fd091d7a6ff4f0c380c3c0897c4f4616de2c5d285e57d5ee28'
  })

  depends_on 'unzip'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'op', "#{CREW_DEST_PREFIX}/bin/op", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'op' to get started.\n"
  end
end
