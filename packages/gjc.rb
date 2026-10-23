require 'package'

class Gjc < Package
  description 'Gajae-Code (gjc) is an external coding-agent harness'
  homepage 'https://github.com/Yeachan-Heo/gajae-code'
  version '0.19.0'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/Yeachan-Heo/gajae-code/releases/download/v#{version}/gjc-linux-x64"
  source_sha256 '9e0cfe2ad0ffd7851211289e927d709f6d30a8f33ee32ae87a3a7f1fdaf9fc18'

  no_compile_needed

  def self.install
    FileUtils.install 'gjc-linux-x64', "#{CREW_DEST_PREFIX}/bin/gjc", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'gjc' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.gjc")
  end
end
