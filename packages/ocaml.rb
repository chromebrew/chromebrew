require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '4.14.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.14/ocaml-4.14.2.tar.xz'
  source_sha256 'c127974d0242576cf47061b20aa9c86d17be0d6aa9687f6ec9835de67be7bb6f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a629b32a38def20b0f751282c0bc1cf596c109a21fcd4127a735441325c80ad0',
     armv7l: 'a629b32a38def20b0f751282c0bc1cf596c109a21fcd4127a735441325c80ad0',
       i686: '9a2d16619143505a9ea699f6f21da22254d570038b536a4f3ea6297ba5119d26',
     x86_64: '4de68fa82f535c5ba8ff8a1a7071b83a89862487ff197b79d4d32f399e07a574'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure -prefix #{CREW_PREFIX} \
      -libdir #{CREW_LIB_PREFIX}"
    system 'make -j1 world.opt'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
