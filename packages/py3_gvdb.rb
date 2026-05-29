require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.36.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b45e070849e5ac8956b9abfc7df2710ec7ee756decd2f2ebf0478c84dfdf429',
     armv7l: '6b45e070849e5ac8956b9abfc7df2710ec7ee756decd2f2ebf0478c84dfdf429',
       i686: 'b5c1c47ed6cd9866a0fa76bce384a31627a7c1f5f08c879395ba26bdd402a856',
     x86_64: 'b6df8d671cbd726dd6ed98272197bd0ba71a63f9054b60d646b920c972f0aa30'
  })

  depends_on 'python3' => :logical

  no_source_build
end
