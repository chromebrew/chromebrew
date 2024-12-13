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
    aarch64: 'b0febfc984247217480a4268557c31250726ff2df9b267608c2c91eecdee1d32',
     armv7l: 'b0febfc984247217480a4268557c31250726ff2df9b267608c2c91eecdee1d32',
       i686: '191f69c05e2d9196d37c6b25013f98f89a52f3841bf2ce29271eff662c408629',
     x86_64: 'd59f8e762e6596b9245437d465445aadb876352b11e4f450d34f28da02c095ac'
  })

  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'glibc' # R
  depends_on 'libcap' # R
  depends_on 'libxslt' => :build

  meson_options '-Dman=enabled'

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
