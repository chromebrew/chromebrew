require 'buildsystems/autotools'

class Makedepend < Autotools
  description 'Makedepend parses C sources in Makefiles to generate dependency lists'
  homepage 'https://www.x.org/wiki/'
  version '1.0.10'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/releases/individual/util/makedepend-#{version}.tar.gz"
  source_sha256 'baf742fb6c76c15febf5181e5cd814066205d8be9aef4abfdc2c54b235e14917'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a13d5bb3237152d693fcf35f9995208ec81935bf688b1acdc7758b15afeaff1',
     armv7l: '0a13d5bb3237152d693fcf35f9995208ec81935bf688b1acdc7758b15afeaff1',
     x86_64: '8514f3cb07bd5096785be7562958127a929e43d987f9f40a37b0b42cbcf6c7af'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11'

  autotools_configure_options '--without-lint'
end
