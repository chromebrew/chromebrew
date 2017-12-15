require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.05.0'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.06/ocaml-4.06.0.tar.xz'
  source_sha256 '1236b5f91e1c075086d69e2d40cfab21e048b9fe38e902f707815bebbc20c5b7'

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
