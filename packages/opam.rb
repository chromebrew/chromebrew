# Adapted from Arch Linux opam PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opam/trunk/PKGBUILD

require 'package'

class Opam < Package
  description 'OCaml package manager'
  homepage 'https://opam.ocaml.org/'
  @_ver = '2.1.1'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/ocaml/opam.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1_armv7l/opam-2.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1_armv7l/opam-2.1.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1_i686/opam-2.1.1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opam/2.1.1_x86_64/opam-2.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '53d3b4e436c1a70f5772523f0af5454aa54ad7dfb777d50fe7495d31160b7462',
     armv7l: '53d3b4e436c1a70f5772523f0af5454aa54ad7dfb777d50fe7495d31160b7462',
    i686: '9dd1d7965cf4f2db86d6f92d5e33228cc4e7b59c0ddfc643ccf022a82a1610f2',
  x86_64: 'f0cced8d7504be9b5bbd2f98d346e28b9cd18cd8b02985722643854a5cd5d51f'
  })

  depends_on 'bubblewrap'
  depends_on 'ocaml'
  depends_on 'rsync' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "make lib-ext all -j1 \
      OCAMLC='ocamlc -unsafe-string' \
      OCAMLOPT='ocamlopt -unsafe-string'"
    @bashd_opam = <<~EOF
      export OPAMROOT=#{CREW_PREFIX}/opam
      eval \$(opam env --root=#{CREW_PREFIX}/opam --switch=default)
      test -r #{CREW_PREFIX}/opam/opam-init/init.sh && . #{CREW_PREFIX}/opam/opam-init/init.sh > /dev/null 2> /dev/null || true
    EOF
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/etc/bash.d]
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/opam", @bashd_opam)
  end

  def self.postinstall
    system "opam init --root=#{CREW_PREFIX}/opam -y \
            && eval \$(opam env --root=#{CREW_PREFIX}/opam --switch=default) \
            && opam option --global depext=false --root=#{CREW_PREFIX}/opam -y"
  end

  def self.remove
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
