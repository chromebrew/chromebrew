require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.52-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '927208ce5198a84e802784aa5427e85ddf165424265c35ad8eb461dcf27f5131',
     armv7l: '927208ce5198a84e802784aa5427e85ddf165424265c35ad8eb461dcf27f5131',
       i686: 'f742384fd1dda0d7ea7fe290a9c7b0118bb29440e5ddebd377fc0a4850f22d08',
     x86_64: 'ce1bfb4d34fa522e87bd703cccbb215d1121a3f62f7a2da841dd2c275c30eceb'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
