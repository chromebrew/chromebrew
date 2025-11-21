require 'buildsystems/autotools'

class Openmpi < Autotools
  description 'The Open MPI Project is an open source Message Passing Interface implementation that is developed and maintained by a consortium of academic, research, and industry partners.'
  homepage 'https://www.open-mpi.org/'
  version '5.0.9'
  license 'BSD'
  compatibility 'aarch64 x86_64'
  source_url 'https://github.com/open-mpi/ompi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '3985ef364b793db8053ae6a3640549a635bdda668134100e3017b17634e82eed'
  })

  def self.prebuild
    system './autogen.pl'
  end
end
