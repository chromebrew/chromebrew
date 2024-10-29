require 'package'

class Wezterm < Package
  description 'WezTerm is a powerful cross-platform terminal emulator and multiplexer'
  homepage 'https://wezfurlong.org/wezterm/'
  version '20240203-110809-5046fc22'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/wez/wezterm/releases/download/#{version}/wezterm-#{version}.Debian12.deb"
  source_sha256 'd3a5c97093fbc0a87e8f9616e44efc4c9503cfc495fd1cfe4ffeff88578d15f8'

  depends_on 'libxkbcommon'
  depends_on 'xcb_util_image'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'etc/profile.d/wezterm.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/wezterm.sh", mode: 0o644
    FileUtils.install 'usr/share/bash-completion/completions/wezterm', "#{CREW_DEST_PREFIX}/etc/bash.d/10-wezterm", mode: 0o644
    FileUtils.mv 'usr/bin', CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
  end
end
