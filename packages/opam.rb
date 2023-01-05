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
    aarch64: '596b3928ed6ebf82b865314ff0601f40f6e2bd8d9d2a0296ab6f45da1afc29cf',
     armv7l: '596b3928ed6ebf82b865314ff0601f40f6e2bd8d9d2a0296ab6f45da1afc29cf',
       i686: 'e21ee0b4989a8d18cc6ea6a0da59c8e214abe3de96104636b6d323195a69f393',
     x86_64: 'bb2a382e59f36eb109eaaa0e471f0e9bc8f74823703fa9e9e0b0e11dfed6d9e7'
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
      test -r #{@OPAMROOT}/opam-init/init.sh && . #{@OPAMROOT}/opam-init/init.sh &> /dev/null || true
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
    return unless Dir.exist? @OPAMROOT

    puts
    print "Would you like to remove #{@OPAMROOT}? [y/N] "
    response = $stdin.gets.chomp.downcase
    case response
    when 'y', 'yes'
      FileUtils.rm_rf @OPAMROOT
      puts "#{@OPAMROOT} removed.".lightred
    else
      puts "#{@OPAMROOT} saved.".lightgreen
    end
    puts
  end
end
