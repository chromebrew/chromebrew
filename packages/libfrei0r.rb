require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.0.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3510440a9ca4c3a4740cb8713b28dbc5bd0b2e8258e242a34fbcdeb443c64ef5',
     armv7l: '3510440a9ca4c3a4740cb8713b28dbc5bd0b2e8258e242a34fbcdeb443c64ef5',
     x86_64: '8ca36c1ba1d0590371a3621ec7b2230a1413c11261f957b0e96a2207fc5e6f46'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
