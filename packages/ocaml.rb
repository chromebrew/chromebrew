require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.05.0'
  source_url 'http://caml.inria.fr/pub/distrib/ocaml-4.05/ocaml-4.05.0.tar.xz'
  source_sha256 '04a527ba14b4d7d1b2ea7b2ae21aefecfa8d304399db94f35a96df1459e02ef9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.05.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.05.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.05.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ocaml-4.05.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '897f5f8ec198ecf1a0f4efd7fc8647084e47d910b009c54bdd52fa152c1cf47b',
     armv7l: '897f5f8ec198ecf1a0f4efd7fc8647084e47d910b009c54bdd52fa152c1cf47b',
       i686: '2adb65a674e740576a827e7f1535a70c202d651b459905809e02f0df51f6e9b8',
     x86_64: '744e1c98a8f5c12e922ed4883aa5d0560656c36069aad8dd43bbe51005cf0563',
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
