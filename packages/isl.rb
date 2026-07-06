require 'buildsystems/autotools'

class Isl < Autotools
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'https://libisl.sourceforge.io/'
  version '0.28'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://libisl.sourceforge.io/isl-#{version}.tar.xz"
  source_sha256 '3dc31b8e1b18329e42d5dfbf84dd55e15c59b61569a2ab246f61497d9592f727'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bede8e2e173d5e9e6fe0c4c616cfba7b392296e2229295b153adb8f2a4184a3',
     armv7l: '9bede8e2e173d5e9e6fe0c4c616cfba7b392296e2229295b153adb8f2a4184a3',
       i686: '07d8321b19c458aebd83306225ea1a83bb07a58a3138f91e7c2f4f9a6a844b7d',
     x86_64: 'b6d5889693323a82f9b400e5bb70f83399e8c29843ad2dd081b57fa6dcd9ba41'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
end
