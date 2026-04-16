require 'buildsystems/autotools'

class Opam < Autotools
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  version '2.5.1'
  license 'LGPL-2.1-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfe2bb9516ab2f0dc802d44d6b7661071ae5e315904abb10842fe1138434f883',
     armv7l: 'cfe2bb9516ab2f0dc802d44d6b7661071ae5e315904abb10842fe1138434f883',
       i686: '85931eb518630a22b9168521ac6c37c6b2dc7280e6145dec9e8f9a209228c028',
     x86_64: '75610ba8c8a9fe2d687b5e44e7749dea16ea1a6affe0a84f1427718eb0f929a0'
  })

  depends_on 'bubblewrap' => :logical
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'ocaml' # R
  depends_on 'rsync' => :build
  depends_on 'zstd' => :executable

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  autotools_configure_options '--with-vendored-deps'

  autotools_build_extras do
    File.write 'opam.sh', <<~OPAMEOF
      export OPAMROOT=#{@OPAMROOT}
      eval $(opam env --root=#{@OPAMROOT} --switch=default)
      test -r #{@OPAMROOT}/opam-init/init.sh && . #{@OPAMROOT}/opam-init/init.sh &> /dev/null || true
    OPAMEOF
  end

  autotools_install_extras do
    FileUtils.install 'opam.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/opam", mode: 0o644
  end

  def self.postinstall
    # Segfaults in container, works on hardware.
    return if CREW_IN_CONTAINER

    system "opam init --root=#{@OPAMROOT} -y \
            && eval $(opam env --root=#{@OPAMROOT} --switch=default) \
            && opam option --global depext=false --root=#{@OPAMROOT} -y"
  end

  def self.postremove
    Package.agree_to_remove(@OPAMROOT.to_s)
  end
end
