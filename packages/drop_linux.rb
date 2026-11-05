require 'package'

class Drop_linux < Package
  description "Linux sandboxing that doesn't get in your way"
  homepage 'https://droprun.sh/'
  version '0.3.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/wrr/drop/releases/download/v#{version}/drop-linux-amd64"
  source_sha256 'aa21b6b9c626ae109c32b403e4eaac51c2c50f775c85e58abedde4116a86b4de'

  depends_on 'passt'

  no_compile_needed

  def self.install
    FileUtils.install 'drop-linux-amd64', "#{CREW_DEST_PREFIX}/bin/drop", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'drop' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.config/drop")
  end
end
