require 'buildsystems/autotools'

class Opam < Autotools
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  version '2.6.0'
  license 'LGPL-2.1-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79e3db3d792ddee9d87355a51f442352ae2fc77545358914056e22a545bd991a',
     armv7l: '79e3db3d792ddee9d87355a51f442352ae2fc77545358914056e22a545bd991a',
       i686: '7ac8396743f2bfe955f8e81a1a29f4b3c994e307f242994fab3b20080384839d',
     x86_64: '69a78fe62077ea7b0536327fa06d432d86303acf3c2f0312648c653d73314d7a'
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
