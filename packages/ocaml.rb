require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.10.0'
  compatibility 'all'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.10/ocaml-4.10.0.tar.gz'
  source_sha256 '58d431dde66f5750ebe9b15d5a1c4872f80d283dec23448689b0d1a498b7e4c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5c473693ab61a9f70f2691b63680009bd1ddf5f237eebdaa9d3ccb02e5cba793',
     armv7l: '5c473693ab61a9f70f2691b63680009bd1ddf5f237eebdaa9d3ccb02e5cba793',
       i686: '9c3772682238e12d8edaf59197c8f6d0343436d0e54055490c39a4f3e67971d3',
     x86_64: 'd2c8383d8761b1d67f244f58bf06cd3bdd49470353e0925abafa4e58906d2571',
  })


  def self.build
    system "./configure -prefix #{CREW_PREFIX} -libdir #{CREW_LIB_PREFIX}"
    system 'make -j1 world.opt'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
