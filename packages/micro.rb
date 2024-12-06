require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '2.0.14'
  license 'MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux-arm.tar.gz"
    source_sha256 '9f490d88bd30a548af99a905f50244dc6c80f3c7a3c6f98faeb5b0a7329f7dea'
  when 'i686'
    source_url "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux32.tar.gz"
    source_sha256 'cbb95a472be2c8de93f57e58dd540cfc799154be5c6031c7ca4b6b8872d13113'
  when 'x86_64'
    source_url "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux64.tar.gz"
    source_sha256 '704e96add9b44e0041179f7934338d330e85230af6869f70b88720830f554786'
  end

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'micro', "#{CREW_DEST_PREFIX}/bin/micro", mode: 0o755
  end
end
