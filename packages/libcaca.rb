require 'buildsystems/autotools'
require 'convenience_functions'

class Libcaca < Autotools
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'https://github.com/cacalabs/libcaca'
  version "0.99.beta20-de48e1a-#{CREW_PY_VER}"
  license 'GPL-2, ISC, LGPL-2.1 and WTFPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/cacalabs/libcaca.git'
  git_hashtag 'de48e1a0888caabdc6276afdea46e9096d0adb05'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c44a06070d65ed96c8949c7b3d60c2e40d07126d3fdd4d48e076170cd26d1d16',
     armv7l: 'c44a06070d65ed96c8949c7b3d60c2e40d07126d3fdd4d48e076170cd26d1d16',
     x86_64: 'bb357b08962db4f387f23d113b06e77b9578fd711240111e45832fa0d18c68a4'
  })

  depends_on 'freeglut' => :library
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'imlib2' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'libglu' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libmd' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :executable
  depends_on 'mesa' => :build
  depends_on 'ncurses' => :library
  depends_on 'python3' => :logical
  depends_on 'slang' => :library
  depends_on 'zlib' => :library

  def self.patch
    patches = [
      [
        # Prevent a divide-by-zero by checking for a zero width or height.
        'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/66.patch',
        'd8a8f7347c5cb7b1f63ef4ef112d7fecd9d39d1703f27fccfab10709fc284d51'
      ],
      [
        # Fix undefined reference to _caca_alloc2d.
        'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/70.patch',
        '173778700c92338a7b6d9f139053574359dd28829c8cdf8418df81632e002b6a'
      ],
      [
        # Mark fallthroughs as explicit in charset.c.
        'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/81.patch',
        '99917c0bc6b0405c8a8a8f4ce8e0df46182ff4db96d6ffb4edbb19ec2ed24b8d'
      ],
      [
        # Fix 32-bit overflow in CVE-2026-42046 patch.
        'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/90.patch',
        'df59ca578f182dc7283ad2616c385bc1ed6a038d1d64d573d021142d31a0e1c6'
      ]
    ]
    ConvenienceFunctions.patch(patches)
  end

  def self.prebuild
    ConvenienceFunctions.libtoolize('freetype')
  end

  autotools_configure_options '--disable-ruby \
      --enable-gl \
      --enable-ncurses \
      --enable-network \
      --enable-slang \
      --enable-x11'
end
