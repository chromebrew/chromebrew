require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version '2024.7.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cf978f0dc1173b79fc7d2e8fa7fbe6f124b52ebf1af32f8536272fa12ad7ebd',
     armv7l: '4cf978f0dc1173b79fc7d2e8fa7fbe6f124b52ebf1af32f8536272fa12ad7ebd',
       i686: '518e2002d41d19fbcd03421639ff7af51bcc26758b46009c65c7ee770ce803aa',
     x86_64: 'a5d6ca5af3b488ac1b53e98bb7fd8ad71c779243459d929a730d1f4f422ba12a'
  })

  depends_on 'python3' => :build

  no_source_build
end
