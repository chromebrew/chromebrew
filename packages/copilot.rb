require 'package'

class Copilot < Package
  description 'AI coding assistant that helps you write code faster and with less effort.'
  homepage 'https://github.com/github/copilot-cli'
  version '1.0.3'
  license 'GitHub Copilot CLI License'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/github/copilot-cli/releases/download/v#{version}/copilot-linux-x64.tar.gz"
  source_sha256 'cf0e569594fda7d476c654e38a34bc95771349e7b6d7905d592bb4db24da7440'

  depends_on 'nodebrew' # R

  def self.preinstall
    node_version = `node -v 2> /dev/null`.chomp
    unless node_version != '' && node_version >= '22'
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
