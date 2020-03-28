require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.10.0'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.10/ocaml-4.10.0.tar.gz'
  source_sha256 '58d431dde66f5750ebe9b15d5a1c4872f80d283dec23448689b0d1a498b7e4c7'

  binary_url ({
  })
  binary_sha256 ({
  })


  def self.build
    system "./configure -prefix #{CREW_PREFIX} -libdir #{CREW_LIB_PREFIX}"
    system 'make -j1 world.opt'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
