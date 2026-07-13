require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.11.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'd03f40a2c495c35e326e160f86753b477144c0c311d416b6c2c11495831a473d',
     armv7l: 'd03f40a2c495c35e326e160f86753b477144c0c311d416b6c2c11495831a473d',
       i686: 'f01ddb3e104f71b25108de25603fb7632ac17585cc6dae40c86ddb037f308927',
     x86_64: 'dc238d6040813e14fc30514dac5a2eb1b430c694f3ca99eee2a5097e55076283'
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
