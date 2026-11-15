require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.11.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '22940b798dfe11aa1c67c9041c32916cec5ceaca132a6ec426e87c92282c64ae',
     armv7l: '22940b798dfe11aa1c67c9041c32916cec5ceaca132a6ec426e87c92282c64ae',
       i686: 'e19ea942f099406cc6f0a9192dd8d0fbf6f236473905c5b10f30a2aaaab3cef0',
     x86_64: 'ea63d4ae232808cd7c6bc00d0142428e231fab59dae01042246097d195835ab6'
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
