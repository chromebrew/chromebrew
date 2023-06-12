# Adapted from Arch Linux opam PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opam/trunk/PKGBUILD

require 'package'

class Opam < Package
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  @_ver = '2.1.4'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.4_armv7l/opam-2.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.4_armv7l/opam-2.1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.4_i686/opam-2.1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.4_x86_64/opam-2.1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '65aea64207802365d889763baffa5d80eb221ba29f4b467b68fc4668e9104e66',
     armv7l: '65aea64207802365d889763baffa5d80eb221ba29f4b467b68fc4668e9104e66',
       i686: '9a840b8be61c55699da697cba15794c1a7164ddc70546c3dc576bc3f1f1348bd',
     x86_64: '194da91d889edbeeb90b80697fc0c57776f9d1b600e6be2ae0326cae8bc29663'
  })

  depends_on 'bubblewrap' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ocaml' # R
  depends_on 'rsync' => :build

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make lib-ext all -j1 \
      OCAMLC='ocamlc -unsafe-string' \
      OCAMLOPT='ocamlopt -unsafe-string'"
    File.write 'opam.sh', <<~OPAMEOF
      export OPAMROOT=#{@OPAMROOT}
      eval $(opam env --root=#{@OPAMROOT} --switch=default)
      test -r #{@OPAMROOT}/opam-init/init.sh && . #{@OPAMROOT}/opam-init/init.sh &> /dev/null || true
    OPAMEOF
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.install 'opam.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/opam", mode: 0o644
  end

  def self.postinstall
    # Segfaults in container, works on hardware.
    return if CREW_IN_CONTAINER

    system "opam init --root=#{@OPAMROOT} -y \
            && eval $(opam env --root=#{@OPAMROOT} --switch=default) \
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
