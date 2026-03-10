require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.7.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'ade39e58c3b3b332a251ac99df6fca8d396382f118475b3d309c64bd44e81aff',
     armv7l: 'ade39e58c3b3b332a251ac99df6fca8d396382f118475b3d309c64bd44e81aff',
       i686: 'fa8979659db61864567ba89f525663e3ce710754746d9c7ede83b12028449c82',
     x86_64: '72dbc77e87b3a6751adc151e514b15f51e2c94e493a561fc9e1138397c6e22c6'
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
