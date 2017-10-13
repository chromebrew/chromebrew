require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.05.0'
  source_url 'http://caml.inria.fr/pub/distrib/ocaml-4.05/ocaml-4.05.0.tar.xz'
  source_sha256 '04a527ba14b4d7d1b2ea7b2ae21aefecfa8d304399db94f35a96df1459e02ef9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential' => :build
  depends_on 'gdbm'

  def self.build
    system "./configure -prefix #{CREW_PREFIX} -libdir #{CREW_LIB_PREFIX} -no-graph"
    system 'make -j1 world.opt'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
