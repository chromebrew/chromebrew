require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.17-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '108eed196a2e990ec49c21e6106c810015c9e90ef63422f931182d38c9dcb59b',
     armv7l: '108eed196a2e990ec49c21e6106c810015c9e90ef63422f931182d38c9dcb59b',
       i686: '7198f7df914f95626b7dcc01336376f469c325a30a632e124c8a2087d405129e',
     x86_64: 'c8eb5f040ddedfcd1ce62cfd80446f0b248fcbacff87cb9d93bbf3d28846e1f7'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'python3' => :logical

  no_source_build
end
