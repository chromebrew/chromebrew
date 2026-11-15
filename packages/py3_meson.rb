require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.12.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a316912810cb94b2ac9b5df4fa2953749bf78915d9bfc835d9f524b48f3f031',
     armv7l: '6a316912810cb94b2ac9b5df4fa2953749bf78915d9bfc835d9f524b48f3f031',
       i686: '96d92efc1170dcd7ffb9bc4b24373f5080f6de1ef4ba32cf8c2d25ddb4eacb16',
     x86_64: '668361795615c1df3d843807f0a6fcd5f2ef7886384896bd6ab52f52c00e4cf7'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
