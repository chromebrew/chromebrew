require 'buildsystems/cmake'

class Halibut < CMake
  description 'Halibut is a documentation production system, with elements similar to TeX, debiandoc-sgml, TeXinfo, and others.'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/halibut/'
  version '1.3'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.chiark.greenend.org.uk/~sgtatham/halibut/halibut-#{version}/halibut-#{version}.tar.gz"
  source_sha256 'aaa0f7696f17f74f42d97d0880aa088f5d68ed3079f3ed15d13b6e74909d3132'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fca8d925335afcce21b9d8259602c8fafdc10549b6501fcb2b35f2dace995e2',
     armv7l: '6fca8d925335afcce21b9d8259602c8fafdc10549b6501fcb2b35f2dace995e2',
       i686: 'c2d2b3455e26ec0272d473d868f5d49dcc4ae37ce10bc7dd7aefcbfb2059cf67',
     x86_64: 'b39d24f538cb1ed90c436b0d5479e7d6fed08266378f218773c977fc5290dc40'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
