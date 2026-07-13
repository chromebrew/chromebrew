require 'buildsystems/autotools'

class Gccmakedep < Autotools
  description 'A utility to list the resource database of an X application.'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.0.5'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.x.org/releases/individual/util/gccmakedep-#{version}.tar.gz"
  source_sha256 '45e6599837170ca3eb84b2b33485c5716c8de0a7ec2d0c9440e2dfc71a476927'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e090d5a887b8414dca5ae2f83d5322f534970484f81e01c805fb359fac8d581e',
     armv7l: 'e090d5a887b8414dca5ae2f83d5322f534970484f81e01c805fb359fac8d581e',
       i686: '30f7429353e187f9fb945e65e42f4320103cfc864d7f63c70c43d0e5b3b6961e',
     x86_64: 'e9caaaf4e8e527008b80d19882cfbc788e53298c17a2e4b933f0fb267a999bad'
  })

  run_tests
end
