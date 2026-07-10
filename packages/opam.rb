require 'buildsystems/autotools'

class Opam < Autotools
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  version '2.5.2'
  license 'LGPL-2.1-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'befa73a8cae283755948733b8a8c5fb0314f3e0c6cd2e63cbc39d7bbeccbce0b',
     armv7l: 'befa73a8cae283755948733b8a8c5fb0314f3e0c6cd2e63cbc39d7bbeccbce0b',
       i686: '568185641c01c30286469ecbde36248bbfbadcfb3a772bc8d871e441c5950fd8',
     x86_64: '7085c2376eb926101413dd200220067bddc1e79be37b3755882276af0592e46a'
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
