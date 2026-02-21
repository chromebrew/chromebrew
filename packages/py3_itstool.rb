require 'buildsystems/pip'

class Py3_itstool < Pip
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'https://itstool.org/'
  version "2.0.7-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ea9de66bc8638d7fdd0d4c86cdad42b8784c59bd58345906b669a85be9d3289',
     armv7l: '3ea9de66bc8638d7fdd0d4c86cdad42b8784c59bd58345906b669a85be9d3289',
       i686: '3db62eac24c81f82d19c0f7770b9977f009e2fc6f9e50729a31667ad9c62b276',
     x86_64: '9b1028b33eaef6fbc5a14c8f51652eb323100a95ebc3e6aad1a813537188bbb2'
  })

  depends_on 'coreutils' if ARCH == 'i686'
  depends_on 'py3_libxml2'
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build

  no_source_build

  pip_install_extras do
    system "sed -i 's,\\\\s,\\\\\\\\s,g' #{CREW_DEST_PREFIX}/bin/itstool"
    system "sed -i 's,\\\\<,\\\\\\\\<,g' #{CREW_DEST_PREFIX}/bin/itstool"
    system "sed -i 's,\\\\>,\\\\\\\\>,g' #{CREW_DEST_PREFIX}/bin/itstool"
    system "sed -i 's,\\\\\.\\[,\\\\\\\\\\.\\[,g' #{CREW_DEST_PREFIX}/bin/itstool"
  end
end
