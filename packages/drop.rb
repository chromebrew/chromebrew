require 'package'

class Drop < Package
  description "Linux sandboxing that doesn't get in your way"
  homepage 'https://droprun.sh/'
  version '0.2.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/wrr/drop/releases/download/v#{version}/drop-linux-amd64"
  source_sha256 'e7398467402f20402db7734b6bab99bd1756297df8c9edd4872d53f55122b790'

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
