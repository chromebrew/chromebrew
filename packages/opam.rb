require 'buildsystems/autotools'

class Opam < Autotools
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  version '2.6.1'
  license 'LGPL-2.1-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7df7141886ec8b656cc47e1d9f9dcd7da1ff4d1404bdd32ff1f315e3acb5242',
     armv7l: 'a7df7141886ec8b656cc47e1d9f9dcd7da1ff4d1404bdd32ff1f315e3acb5242',
       i686: 'b8bc3c43c7735a61dfafaadd3df58192a605d27587d0df9ea09f183922d5700c',
     x86_64: '272236b8a6a57fe234702281e859460cbde9656c5b8edcf878b0b8e5afe93e27'
  })

  depends_on 'bubblewrap' => :logical
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
