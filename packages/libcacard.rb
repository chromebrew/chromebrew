require 'buildsystems/meson'

class Libcacard < Meson
  description 'Common Access Card library that provides emulation of smart cards to a virtual card reader running in a guest virtual machine'
  homepage 'https://gitlab.freedesktop.org/spice/libcacard'
  version '2.8.2'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/spice/libcacard.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d75d17ee26620cd478eae1c3879c51e2af21b422567e35d31ae07f625289e03',
     armv7l: '3d75d17ee26620cd478eae1c3879c51e2af21b422567e35d31ae07f625289e03',
       i686: 'fcff909400ab70b7d4ca70fdeb61fcc35781484a4c2c63b74d6d0ff8035e62ee',
     x86_64: 'd6f489b275ef77975dc1a9af0445eb38bc03699e23730e1d36f0ceb29dcfcdfb'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nss' => :library

  run_tests
end
