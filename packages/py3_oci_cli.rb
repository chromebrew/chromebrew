require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.49.4-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90014fdedb04ab046240e12626bc777a3ea6c633f51a6900dc61fd8c190afec4',
     armv7l: '90014fdedb04ab046240e12626bc777a3ea6c633f51a6900dc61fd8c190afec4',
     x86_64: '238a6fae4f82444b9cb7d29cc2ae6001981940cfae71e4a67845b568f0383b0e'
  })

  depends_on 'py3_arrow'
  depends_on 'py3_six'
  depends_on 'py3_terminaltables'
  depends_on 'py3_certifi'
  depends_on 'py3_python_dateutil'
  depends_on 'py3_click'
  depends_on 'py3_jmespath'
  depends_on 'py3_retrying'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_pyyaml'
  depends_on 'py3_cryptography'
  depends_on 'py3_configparser'
  depends_on 'py3_pytz'
  depends_on 'py3_oci'
  depends_on 'python3' => :build

  no_source_build
end
