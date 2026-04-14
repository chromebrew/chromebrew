require 'buildsystems/meson'

class Bubblewrap < Meson
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  version '0.11.1'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{version}/bubblewrap-#{version}.tar.xz"
  source_sha256 'c1b7455a1283b1295879a46d5f001dfd088c0bb0f238abb5e128b3583a246f71'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c0086c78e562a6fe025ecc5a1907a86c65be1897fe40c654456a02c687fe6ca',
     armv7l: '0c0086c78e562a6fe025ecc5a1907a86c65be1897fe40c654456a02c687fe6ca',
       i686: '03101523d589234d8698f67fc9c16bc9960fbaa62ac67288981f03610b9931fe',
     x86_64: '913623af164bf957debeaa12feb862ffb74183e76ae043422820814a7105d7a1'
  })

  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'glibc' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libxslt' => :build

  print_source_bashrc

  meson_options '-Dman=enabled'

  meson_build_extras do
    File.write '10-bwrap', <<~BWRAP_COMPLETION
      #!/bin/bash
      source #{CREW_PREFIX}/share/bash-completion/completions/bwrap
    BWRAP_COMPLETION
    File.write 'bwrap.sh', <<~BWRAP_HEREDOC
      #!/bin/bash
      sudo chown root "#{CREW_PREFIX}/bin/bwrap.elf"
      sudo chmod +s "#{CREW_PREFIX}/bin/bwrap.elf"
      #{CREW_PREFIX}/bin/bwrap.elf "$@"
      sudo chown chronos "#{CREW_PREFIX}/bin/bwrap.elf"
    BWRAP_HEREDOC
  end

  meson_install_extras do
    FileUtils.install '10-bwrap', "#{CREW_DEST_PREFIX}/etc/env.d/10-bwrap", mode: 0o644
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/bwrap", "#{CREW_DEST_PREFIX}/bin/bwrap.elf", mode: 0o755
    FileUtils.install 'bwrap.sh', "#{CREW_DEST_PREFIX}/bin/bwrap", mode: 0o755
  end
end
