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
    aarch64: '6c0f4519176c1bb8ff894f4ddbd0cd49fac2529a5f2b9a2ba2337fcdcc1d574f',
     armv7l: '6c0f4519176c1bb8ff894f4ddbd0cd49fac2529a5f2b9a2ba2337fcdcc1d574f',
       i686: '12ffb4aa4e2c087810f366f1fccd05241c7b5b1344d45e09f096d3f02b881d49',
     x86_64: 'd715cf4f5fb510f7958be4e8ace1b9eeab2d816f96a59e4d46e79a3c7f794b76'
  })

  run_tests
end
