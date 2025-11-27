require 'buildsystems/meson'

class Libcacard < Meson
  description 'Common Access Card library that provides emulation of smart cards to a virtual card reader running in a guest virtual machine'
  homepage 'https://gitlab.freedesktop.org/spice/libcacard'
  version '2.8.1'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/spice/libcacard.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8b86a163c09718f1461b6e1f20bd21bf6283c2ee3095614f387d4ebc9e34c0f',
     armv7l: 'a8b86a163c09718f1461b6e1f20bd21bf6283c2ee3095614f387d4ebc9e34c0f',
       i686: 'a4fdee78a6c9b6a7d0d9e703b553036e1877ae6645ccd8eac4a0278f2b429621',
     x86_64: 'ef452da27348154a81ba090dbfcf96a64e61dd6f3e2ff2ca167f9cbcde15deaa'
  })

  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'nss'

  run_tests
end
