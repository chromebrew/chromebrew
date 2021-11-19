# Adapted from Arch Linux opam PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opam/trunk/PKGBUILD

require 'package'

class Opam < Package
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  @_ver = '2.1.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1-1_armv7l/opam-2.1.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1-1_armv7l/opam-2.1.1-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1-1_x86_64/opam-2.1.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ec54d9008a122e6e4050c43357de070086aa2d1cf4b1b770eacb2ff5e2753ca4',
     armv7l: 'ec54d9008a122e6e4050c43357de070086aa2d1cf4b1b770eacb2ff5e2753ca4',
     x86_64: 'c09d490e44d8e4ac4c723b7421f7b9203d8a7b3a8810f6505b1e3d1344505509'
  })

  depends_on 'bubblewrap'
  depends_on 'ocaml'
  depends_on 'rsync'

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "make lib-ext all -j1 \
      OCAMLC='ocamlc -unsafe-string' \
      OCAMLOPT='ocamlopt -unsafe-string'"
    @bashd_opam = <<~OPAMEOF
      export OPAMROOT=#{@OPAMROOT}
      eval \$(opam env --root=#{@OPAMROOT} --switch=default)
      test -r #{@OPAMROOT}/opam-init/init.sh && . #{@OPAMROOT}/opam-init/init.sh > /dev/null 2> /dev/null || true
    OPAMEOF
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/etc/bash.d]
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/opam", @bashd_opam)
  end

  def self.postinstall
    system "opam init --root=#{@OPAMROOT} -y \
            && eval \$(opam env --root=#{@OPAMROOT} --switch=default) \
            && opam option --global depext=false --root=#{@OPAMROOT} -y"
  end

  def self.remove
    # Leave this in until the next revision
    if Dir.exist? "#{CREW_PREFIX}/opam"
      puts
      print "Would you like to remove #{CREW_PREFIX}/opam? [y/N] "
      response = $stdin.getc
      case response
      when 'y', 'Y'
        FileUtils.rm_rf "#{CREW_PREFIX}/opam"
        puts "#{CREW_PREFIX}/opam removed.".lightred
      else
        puts "#{CREW_PREFIX}/opam saved.".lightgreen
      end
      puts
    end
  end
end
