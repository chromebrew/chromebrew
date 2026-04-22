require 'package'

class Copilot < Package
  description 'AI coding assistant that helps you write code faster and with less effort.'
  homepage 'https://github.com/github/copilot-cli'
  version '1.0.34'
  license 'GitHub Copilot CLI License'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/github/copilot-cli/releases/download/v#{version}/copilot-linux-x64.tar.gz"
  source_sha256 '2670c0aa92b29e3aa4046b41417b074b9888fbeca9065901a435d374dacc7084'

  depends_on 'nodebrew' # R

  no_compile_needed

  def self.preinstall
    # Get the major node version.
    node_version = `node -v 2> /dev/null`
    if node_version.empty?
      abort <<~EOM.lightred
        Node.js is not installed. Use nodebrew to install a compatible version.
        Example: source ~/.bashrc && nodebrew install 22 && nodebrew use 22
      EOM
    end
    node_major_version = node_version.gsub(/[^\d^.]/, '').split('.')[0].chomp
    unless node_major_version >= '22'
      abort <<~EOM.lightred
        Node.js version must be >= 22. Use nodebrew to install a compatible version.
        Example: source ~/.bashrc && nodebrew install 22 && nodebrew use 22
      EOM
    end
  end

  def self.install
    FileUtils.install 'copilot', "#{CREW_DEST_PREFIX}/bin/copilot", mode: 0o755
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.copilot")
  end
end
