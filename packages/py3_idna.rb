require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version '3.9-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8664822f6157e92b8fed191e85e33216a60c32db4900be779f4311f7240a8be',
     armv7l: 'b8664822f6157e92b8fed191e85e33216a60c32db4900be779f4311f7240a8be',
       i686: 'c9bd9415d84fe223489796692d36f67e2bff4cff35e28099d998dd882ab8f9a9',
     x86_64: 'a2e85e5209722ed0ecc4e3f03f7dff905a26e87f7189e35a55242896f32e9172'
  })

  depends_on 'python3' => :build

  no_source_build
end
