require 'buildsystems/autotools'

class Openmpi < Autotools
  description 'The Open MPI Project is an open source Message Passing Interface implementation that is developed and maintained by a consortium of academic, research, and industry partners.'
  homepage 'https://www.open-mpi.org/'
  version '5.0.8amzn1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/open-mpi/ompi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ebfd586e6e8efcbdda5ec1c69356bf29adc2c15844405fc9fd6b595330cebff',
     armv7l: '6ebfd586e6e8efcbdda5ec1c69356bf29adc2c15844405fc9fd6b595330cebff',
       i686: '7b95e3be4d88619c4abdbe3df69534b023955699ec7633f310cb77bf320514d0',
     x86_64: '3985ef364b793db8053ae6a3640549a635bdda668134100e3017b17634e82eed'
  })
end
