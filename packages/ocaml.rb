require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.12.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.12/ocaml-4.12.0.tar.gz'
  source_sha256 '9825e5903b852a7a5edb71a1ed68f5d5d55d6417e2dda514dda602bc6efeed7b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.12.0_armv7l/ocaml-4.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.12.0_armv7l/ocaml-4.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.12.0_i686/ocaml-4.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.12.0_x86_64/ocaml-4.12.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6da8eaf154e9e5be53d49ba12704cf3ad857fce4b404be44104a2b4417440e9b',
     armv7l: '6da8eaf154e9e5be53d49ba12704cf3ad857fce4b404be44104a2b4417440e9b',
       i686: 'be55c4f17d4e59e9ad0d259051c6ba932a3fd7fa1d098f61b0057938a0937c60',
     x86_64: 'ee67fbd27e5c180c98c452a095feb8a0a113019cd2cc883d8749e066ac8109ba'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure -prefix #{CREW_PREFIX} \
      -libdir #{CREW_LIB_PREFIX}"
    system 'make -j1 world.opt'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
