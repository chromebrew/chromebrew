require 'package'

class Copilot < Package
  description 'AI coding assistant that helps you write code faster and with less effort.'
  homepage 'https://github.com/github/copilot-cli'
  version '1.0.8'
  license 'GitHub Copilot CLI License'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/github/copilot-cli/releases/download/v#{version}/copilot-linux-x64.tar.gz"
  source_sha256 '948aa3b282f42387c759fbed6d8485e12cd3300ce561473b48af988b8e5306b3'

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
