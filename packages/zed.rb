require 'package'

class Zed < Package
  description 'Zed is a high-performance, multiplayer code editor'
  homepage 'https://zed.dev/'
  version '0.182.11'
  license 'GPL-3, AGPL-3, Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/zed-industries/zed/releases/download/v#{version}/zed-linux-x86_64.tar.gz"
  source_sha256 '6e31a7a40ebc942e630370b6146afce14c4f869cc94f21fe6979ee5ed859b724'

  depends_on 'alsa_lib'
  depends_on 'libbsd'
  depends_on 'libxau'
  depends_on 'libxcb'
  depends_on 'libxdmcp'
  depends_on 'libxkbcommon'
  depends_on 'openssl'
  depends_on 'zlib'
  depends_on 'zstd'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX.to_s
    FileUtils.mv 'bin/', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'share/', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'libexec/', CREW_DEST_PREFIX.to_s
  end

  def self.postinstall
    ExitMessage.add "\nType 'zed' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/zed")
  end
end
