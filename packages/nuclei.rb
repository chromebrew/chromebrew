require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.10.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '283bed0f2a850c4e76b77e4b4eb7acc06b61758ea033ba7dcc5fa13ea4c6f02f',
     armv7l: '283bed0f2a850c4e76b77e4b4eb7acc06b61758ea033ba7dcc5fa13ea4c6f02f',
       i686: '8cb9f1ba769d7aa857932018d467641a5022aeae5ce799ecb20ecc18f43f7ee8',
     x86_64: 'a8643ea48c847544f24e6d4fe5e9a7239fc9d1aadac52edc5ac673837855e657'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'nuclei', "#{CREW_DEST_PREFIX}/bin/nuclei", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'nuclei' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.pdcp")
    Package.agree_to_remove("#{HOME}/nuclei-templates")
  end
end
