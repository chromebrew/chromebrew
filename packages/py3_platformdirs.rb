require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version '4.3.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '697bf3989582c11dc114469fcd4019eadc9a15088f77d55feaac8a6480e492cb',
     armv7l: '697bf3989582c11dc114469fcd4019eadc9a15088f77d55feaac8a6480e492cb',
       i686: '86b07748eacd25ddda4ff8818fe461451d20472a0ec5cd4416b75bed3d167746',
     x86_64: '230f88a125d46b9042c82193743f90e2aaaea27460bf492320c350b4b24f39ce'
  })

  depends_on 'python3' => :build

  no_source_build
end
