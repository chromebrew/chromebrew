require 'buildsystems/cmake'

class Grive < CMake
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.3-be52cb2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vitalif/grive2.git'
  git_hashtag 'be52cb21a7ea5c16db0d5f3b22f1864629ff36ae'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c142f5806d8d3fecc0bb79b15773a9ea2de3db045722997c40f0e64f3f91291',
     armv7l: '3c142f5806d8d3fecc0bb79b15773a9ea2de3db045722997c40f0e64f3f91291',
     x86_64: '0bcda1451b828a83ae646376261de9b48c3e6d6d64e9a059eb2a6f46430b6c9e'
  })

  depends_on 'binutils' => :executable
  depends_on 'boost' => :executable
  depends_on 'cppunit' => :build
  depends_on 'curl' => :executable
  depends_on 'expat' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libgcrypt' => :executable
  depends_on 'libgpg_error' # R
  depends_on 'yajl' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  def self.patch
    patches = [
      [
        # Boost 1.89 Build Fix.
        'https://patch-diff.githubusercontent.com/raw/vitalif/grive2/pull/410.diff',
        '0142205b3892af8ad828436fa7e7077ee36aa890bfd0324102a95cf87ed86366'
      ],
      [
        # Use pkg-config to find libgcrypt build configs.
        'https://patch-diff.githubusercontent.com/raw/vitalif/grive2/pull/403.diff',
        'a98767f63abbb930b738be081ab8a230926818f7a3e3bfa413876c1184a4be86'
      ]
    ]
    ConvenienceFunctions.patch(patches)
  end
end
