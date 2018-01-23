require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.06.0'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.06/ocaml-4.06.0.tar.xz'
  source_sha256 '1236b5f91e1c075086d69e2d40cfab21e048b9fe38e902f707815bebbc20c5b7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.06.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.06.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.06.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.06.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '66f2bf801661c70eb4779f8075da2454b13f4b71cb3efe8680e487c54d539bb2',
     armv7l: '66f2bf801661c70eb4779f8075da2454b13f4b71cb3efe8680e487c54d539bb2',
       i686: 'c5942aa70696eee4c242f27a85751c7823f556eb36804f1171fde1ea64f53ba2',
     x86_64: '3855090573fb7a460c65f2c2705d8f73cf011e79f925a30508397c9ae2376a6f',
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
