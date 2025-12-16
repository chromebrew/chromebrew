require 'buildsystems/pip'

class Py3_agate_sql < Pip
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  version "0.7.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1af9eae62160c58694a729223d06d7234f51c2fb9d7a53d110a6d444c2917fdd',
     armv7l: '1af9eae62160c58694a729223d06d7234f51c2fb9d7a53d110a6d444c2917fdd',
       i686: '4cc0d2af26324f05409dfd934588b6bcdeb35bbe7c38e13ecc9b6fa9a6bbda44',
     x86_64: 'd6f38882a4f888c08fa79b853f57662d8f621c7805ba1ceea6d0255db1743b55'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
