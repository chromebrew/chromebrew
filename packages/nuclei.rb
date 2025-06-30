require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.4.6'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'faba038a3946d582ecf4f301f45400a13fee64afa48733808dbd440acd85b889',
     armv7l: 'faba038a3946d582ecf4f301f45400a13fee64afa48733808dbd440acd85b889',
       i686: '5d05f8a3a75cf54bb0699719f045cf7c7f3275e4f7a8f55c34058f2b4f2c4ca2',
     x86_64: 'd54bad8d9895d45681540eb517f7debc68c9688b8d7ca9808598f6cdeabcc0d4'
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
