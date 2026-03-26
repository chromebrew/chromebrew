require 'package'

class S < Package
  description 'Open a web search in your terminal.'
  homepage 'https://github.com/zquestz/s/'
  version '0.7.5'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.32'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://github.com/zquestz/s/releases/download/v#{version}/s-linux_arm.zip"
    source_sha256 '0e995ab36fd2a08d6ab60ad2dcbe01a516906a469d58b8c77d04b33fb8efed1b'
  when 'x86_64'
    source_url "https://github.com/zquestz/s/releases/download/v#{version}/s-linux_amd64.zip"
    source_sha256 '538b0324ddf317dce92c1e605189b93f46af961820ee101775f3d13d28831112'
  end

  depends_on 'unzip' => :executable

  no_compile_needed

  def self.install
    FileUtils.install 's', "#{CREW_DEST_PREFIX}/bin/s", mode: 0o755
  end
end
