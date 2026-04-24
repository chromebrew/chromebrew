require 'buildsystems/meson'

class Bubblewrap < Meson
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  version '0.11.2'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{version}/bubblewrap-#{version}.tar.xz"
  source_sha256 '69abc30005d2186baf7737feacd8da35633b93cf5af38838ecff17c5f8e924f6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd243f81547417528cc1162bd2eca1148b0bb3349ef5d822684c59c363fc0ca2e',
     armv7l: 'd243f81547417528cc1162bd2eca1148b0bb3349ef5d822684c59c363fc0ca2e',
       i686: 'd456c9bd0a57f698cc7543d69daedd54af13c79954a3609ba97c9e56336a8557',
     x86_64: '8b587954c872a370b66484eb611e6aa28b06df33be2866fb930e7d2e7f47c06d'
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
