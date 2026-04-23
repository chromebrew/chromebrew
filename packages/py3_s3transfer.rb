require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.16.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad9f404135b54c37161a5450bf1f1aeeef914b4c1005b2b494cd348e261968d3',
     armv7l: 'ad9f404135b54c37161a5450bf1f1aeeef914b4c1005b2b494cd348e261968d3',
       i686: 'dce10ff6cf298e3ce492c90cdc753a6461c63b23378cc626900b5ad95f6151fb',
     x86_64: 'd518a3cdb919bf399a57661d235f4b2d464f6d97623ea0b2deb452afc85fc6e3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
