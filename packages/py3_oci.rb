require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.187.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36fb71b92aab5531b1a608680bbefffe1f3adb52c3c0d76f7d79969ce4b4e5c1',
     armv7l: '36fb71b92aab5531b1a608680bbefffe1f3adb52c3c0d76f7d79969ce4b4e5c1',
       i686: '8f2a1cdeb466584cba3e143460eefb489a11fc770137ece6843b9665813b69af',
     x86_64: '0bec76f41eb775f2a861f8717c4a23f4ade06ab5e6cb09df1c38a88f11545160'
  })

  depends_on 'py3_certifi'
  depends_on 'py3_configparser'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_python_dateutil'
  depends_on 'py3_pytz'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
