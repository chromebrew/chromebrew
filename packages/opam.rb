# Adapted from Arch Linux opam PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opam/trunk/PKGBUILD

require 'package'

class Opam < Package
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  @_ver = '2.1.2'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.2_armv7l/opam-2.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.2_armv7l/opam-2.1.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.2_i686/opam-2.1.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.2_x86_64/opam-2.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dc177f2bb38e12fd6ce7c697117a661edc6ad67ca9b7249c7661c43f8e218a52',
     armv7l: 'dc177f2bb38e12fd6ce7c697117a661edc6ad67ca9b7249c7661c43f8e218a52',
       i686: '57f36dfc182d5719229f8ef883be8e878160ab116bb8c004a8ce3bdf5a802dd1',
     x86_64: '612c10ea82c335d79c6a06e5abf9da93e873f3419574a7a93a17fa284c913daf'
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
    if Dir.exist? @OPAMROOT
      puts
      print "Would you like to remove #{@OPAMROOT}? [y/N] "
      response = $stdin.getc
      case response
      when 'y', 'Y'
        FileUtils.rm_rf @OPAMROOT
        puts "#{@OPAMROOT} removed.".lightred
      else
        puts "#{@OPAMROOT} saved.".lightgreen
      end
      puts
    end
  end
end
