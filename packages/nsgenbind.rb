require 'buildsystems/autotools'

class Nsgenbind < Autotools
  description 'Tool to generate javascript to dom bindings from w3c webid files'
  homepage 'https://www.netsurf-browser.org'
  version '0.9'
  license 'MIT'
  compatibility 'all'
  source_url "https://download.netsurf-browser.org/libs/releases/nsgenbind-#{version}-src.tar.gz"
  source_sha256 '232ce0f66cbc2c3eed6288ae26de2c567bbfbbc01d8b0f6fc6c1c1649d4b385d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7688c6172d4548e03751e38d9e05d097d9abef09d9b946a6baf7e6e1cbe93e5b',
     armv7l: '7688c6172d4548e03751e38d9e05d097d9abef09d9b946a6baf7e6e1cbe93e5b',
       i686: '059a63b0bed8ec8f4daad79087a74b8bc3f97ca8fe2de9b4786fb229c81e988e',
     x86_64: 'b32b91aac310ebb64dcef8d0572e8dab38922880b759fe0d8411707006a07e66'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'netsurf_buildsystem' => :build

  autotools_skip_configure
  autotools_make_options "PREFIX=#{CREW_PREFIX} FLEX=flex BISON=bison"
  autotools_install_options "PREFIX=#{CREW_PREFIX} FLEX=flex BISON=bison"
end
