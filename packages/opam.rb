require 'buildsystems/autotools'

class Opam < Autotools
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  version '2.5.0'
  license 'LGPL-2.1-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80f5390b1872e2dfc9423e5bee0d8dcced5b2b48d21fa4c7929bc3276972dbbe',
     armv7l: '80f5390b1872e2dfc9423e5bee0d8dcced5b2b48d21fa4c7929bc3276972dbbe',
       i686: '33f8fdead10669d19bc320c8d832a73a5fd3fe654720b818730a0d2b98f770d3',
     x86_64: 'b29ed962d59e82b7b3000af31ad2edead24682720aff68c1a568ea301ca44302'
  })

  depends_on 'bubblewrap' # L
  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'ocaml' # R
  depends_on 'rsync' => :build
  depends_on 'zstd' => :executable_only

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
