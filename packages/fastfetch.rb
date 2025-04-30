# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.42.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '944bd9ff6ad0aae3cb20f9d5d1a324112c7f7a4327160883c5440aa3cc74283f',
     armv7l: '944bd9ff6ad0aae3cb20f9d5d1a324112c7f7a4327160883c5440aa3cc74283f',
       i686: 'f7b37001b542c035b7a662cea8e3b52badc176e94baaee349fc353a1959089a9',
     x86_64: '51bd182ee9893ff245f687399a6b5ae2c44fbc6d21d4db218bf5665089e13244'
  })

  depends_on 'gcc_lib'
  depends_on 'chafa' => :build
  depends_on 'sqlite' => :build
  depends_on 'glibc' # R
  depends_on 'yyjson' # R

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
