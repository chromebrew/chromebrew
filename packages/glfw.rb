require 'buildsystems/cmake'

class Glfw < CMake
  description 'GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides a simple API for creating windows, contexts and surfaces, receiving input and events.'
  homepage 'http://www.glfw.org/'
  version '3.4'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/glfw/glfw/releases/download/3.4/glfw-3.4.zip'
  source_sha256 'b5ec004b2712fd08e8861dc271428f048775200a2df719ccf575143ba749a3e9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '375586eebe407a72dd6e819c236c75d45cdb6af2fb284452d92767ec0586a031',
     armv7l: '375586eebe407a72dd6e819c236c75d45cdb6af2fb284452d92767ec0586a031',
     x86_64: '270e70447b7d59eb1db3ed2224f2542e45b864d6d56152236dcc22ea6a85cd1d'
  })

  depends_on 'glibc' # R
  depends_on 'libxi' => :build
  depends_on 'libxinerama' => :build
  depends_on 'sommelier' => :build

  cmake_options '-DGLFW_BUILD_DOCS=OFF -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=ON'
end
