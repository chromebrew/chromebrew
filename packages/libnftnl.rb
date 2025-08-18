require 'buildsystems/autotools'

class Libnftnl < Autotools
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.3.0'
  compatibility 'all'
  source_url "https://netfilter.org/projects/libnftnl/files/libnftnl-#{version}.tar.xz"
  source_sha256 '0f4be47a8bb8b77a350ee58cbd4b5fae6260ad486a527706ab15cfe1dd55a3c4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7ad02d448372531cd696b6589c7da21f12ec1b18d825b9452bcb327ef81448f',
     armv7l: 'b7ad02d448372531cd696b6589c7da21f12ec1b18d825b9452bcb327ef81448f',
       i686: '10c7d2e6ea6b61a14e1d75094b5dedbe5c648db3a4b7aa5523655c9830715a2d',
     x86_64: '9da428e9bfeff45510a746b7508d886d488f9676988dd0db718050df565baa06'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests
end
