require 'package'

class Nuclei < Package
  description 'Fast, customizable vulnerability scanner'
  homepage 'https://docs.projectdiscovery.io/tools/nuclei'
  version '3.9.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
     armv7l: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_arm.zip",
       i686: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_386.zip",
     x86_64: "https://github.com/projectdiscovery/nuclei/releases/download/v#{version}/nuclei_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'bc205c98d1174e9d9134dc968c337a60ff69fb9ee98ee9b8f760f8040460b528',
     armv7l: 'bc205c98d1174e9d9134dc968c337a60ff69fb9ee98ee9b8f760f8040460b528',
       i686: '4d67f3a3416361b1e17ee2d73cbbef4146bf9ab1eaa85cd2fda3755d8037eb88',
     x86_64: '05357e07886d9670e9c54325ec8afd362d03610c87e2aa1455886ad3f7b58519'
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
