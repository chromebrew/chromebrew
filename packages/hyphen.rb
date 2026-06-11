require 'buildsystems/autotools'

class Hyphen < Autotools
  description 'hyphenation library to use converted TeX hyphenation patterns'
  homepage 'https://github.com/hunspell/hyphen'
  version '2.8.9'
  license 'GPL-2, LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hyphen.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78bb2fd8416730724d11d8393147f47e68caf8bf8b23dea3c47745e6afaf188c',
     armv7l: '78bb2fd8416730724d11d8393147f47e68caf8bf8b23dea3c47745e6afaf188c',
       i686: '326c7c59b48cf5b0fa24245806b06d14336f46db8bbc05f70c1d21ba42fd75fc',
     x86_64: '4ee39ad89a470f041d6dda847055f4aea4e35d7b35ee0bf79a2c64c3f19d9ef0'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
