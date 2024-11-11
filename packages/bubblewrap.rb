require 'buildsystems/meson'

class Bubblewrap < Meson
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  version '0.11.0'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{version}/bubblewrap-#{version}.tar.xz"
  source_sha256 '988fd6b232dafa04b8b8198723efeaccdb3c6aa9c1c7936219d5791a8b7a8646'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b0d4fb6f95057a8eaee2a38611a6f87ff5f24729ca8a6e1946ba3322dcfd59b',
     armv7l: '9b0d4fb6f95057a8eaee2a38611a6f87ff5f24729ca8a6e1946ba3322dcfd59b',
       i686: '0fb5b33471ff70119fc060dfe5fbb00779caa3fc982e5bbe6961afbe7a560dcc',
     x86_64: '328728bf2901f320a45383ae8e2056c78514cefd74abc5bd48323735e2136bd0'
  })

  depends_on 'dconf' => :build
  depends_on 'glibc' # R
  depends_on 'libcap' # R

  meson_build_extras do
    File.write 'bwrap.sh', <<~BWRAP_HEREDOC
      #!/bin/bash
      sudo chown root "#{CREW_PREFIX}/bin/bwrap.elf"
      sudo chmod +s "#{CREW_PREFIX}/bin/bwrap.elf"
      #{CREW_PREFIX}/bin/bwrap.elf "$@"
      sudo chown chronos "#{CREW_PREFIX}/bin/bwrap.elf"
    BWRAP_HEREDOC
  end

  meson_install_extras do
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/bwrap", "#{CREW_DEST_PREFIX}/bin/bwrap.elf", mode: 0o755
    FileUtils.install 'bwrap.sh', "#{CREW_DEST_PREFIX}/bin/bwrap", mode: 0o755
  end
end
