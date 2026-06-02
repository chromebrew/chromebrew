require 'buildsystems/meson'

class Xauth < Meson
  description 'X authority file utility'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xauth.1.html'
  version '1.1.5-1'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xauth.git'
  git_hashtag "xauth-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da7324ed519b8a1ceac706683bd999ab39606207571df58fa61c18caa2c644ba',
     armv7l: 'da7324ed519b8a1ceac706683bd999ab39606207571df58fa61c18caa2c644ba',
     x86_64: 'a3ed811eff09239f23bc2497f1b1d9c5ea05dd32032c705e09ca59407d9f26c3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libx11' => :library
  depends_on 'libxau' => :executable
  depends_on 'libxau' => :library
  depends_on 'libxext' => :executable
  depends_on 'libxext' => :library
  depends_on 'libxmu' => :executable
  depends_on 'libxmu' => :library
  depends_on 'libxtrans' => :build

  def self.patch
    patches = [
      # Add Meson support
      ['https://gitlab.freedesktop.org/xorg/app/xauth/-/merge_requests/30.diff', '4c60f1f0e0297f54c253aace39750688636a96d85323dd3868f67ad81f6ce83e']
    ]
    ConvenienceFunctions.patch(patches) if version.include?('1.1.5')
  end
end
