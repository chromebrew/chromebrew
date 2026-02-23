require 'buildsystems/autotools'

class Help2man < Autotools
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.49.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/help2man/help2man-#{version}.tar.xz"
  source_sha256 '4d7e4fdef2eca6afe07a2682151cea78781e0a4e8f9622142d9f70c083a2fd4f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '662645a25d82d901659deb87df5aa4691c9334fff4c3ebdf3245b4d5db9faa75',
     armv7l: '662645a25d82d901659deb87df5aa4691c9334fff4c3ebdf3245b4d5db9faa75',
       i686: '7709de610e92298602742df0d6abba78fe29663fe4b9c6beb9444133a45416be',
     x86_64: '80398327a3f399cd033bd1d0d093ee92f03ba28a81904d6c490d0f93ba72db54'
  })
end
