require 'package'

class Gjc < Package
  description 'Gajae-Code (gjc) is an external coding-agent harness'
  homepage 'https://github.com/Yeachan-Heo/gajae-code'
  version '0.22.1'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/Yeachan-Heo/gajae-code/releases/download/v#{version}/gjc-linux-x64"
  source_sha256 '4fe2168b1cdf86528170e20a8c2b9b0ad7f5f0be314d96c9a06d66d7856dc0a6'

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
