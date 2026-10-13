require 'package'

class Gjc < Package
  description 'Gajae-Code (gjc) is an external coding-agent harness'
  homepage 'https://github.com/Yeachan-Heo/gajae-code'
  version '0.18.11'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/Yeachan-Heo/gajae-code/releases/download/v#{version}/gjc-linux-x64"
  source_sha256 '9e2ac3e801776664df7c987db4dc83f2c98a419b657eff94439099e8eb0cf966'

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
