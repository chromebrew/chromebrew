require 'buildsystems/autotools'

class Calcurse < Autotools
  description 'calcurse is a calendar and scheduling application for the command line.'
  homepage 'https://calcurse.org/'
  version '4.9.0'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://calcurse.org/files/calcurse-#{version}.tar.gz"
  source_sha256 '1e7b549af7518f0ea08bee118032f86d73875f5140980972f1a728d8ad483661'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bacaa45f901236e9a5377fe90c8c1736af9ff77f33c4ff24b0c0d63971146198',
     armv7l: 'bacaa45f901236e9a5377fe90c8c1736af9ff77f33c4ff24b0c0d63971146198',
       i686: '4f75d53c4461d52f0dd030a691992b08300e1cbe6a120fe03eab151ca1a68b75',
     x86_64: '47216382b58231ddf5bb112b853177cd4ca7d1f9c9e3c691580fbb38159faaab'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
