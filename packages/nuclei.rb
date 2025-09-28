require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.4.10'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'e8d79f94076083f6b434092ae93cbc5e51f8e087c8aed21a7e086b8c1ca1a4ca',
     armv7l: 'e8d79f94076083f6b434092ae93cbc5e51f8e087c8aed21a7e086b8c1ca1a4ca',
       i686: '35fdf9077c6c4f3e448d473e7946964b36e9b4f91317ab2dd37a14b86509f037',
     x86_64: '234c12cc5288af071abdcd6f854245b6067345556e1235cf96b76725c1004357'
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
    Package.agree_to_remove("#{HOME}/nuclei-templates")
  end
end
