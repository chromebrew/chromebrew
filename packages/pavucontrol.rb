require 'buildsystems/meson'

class Pavucontrol < Meson
  description 'PulseAudio Volume Control'
  homepage 'https://freedesktop.org/software/pulseaudio/pavucontrol/'
  version '6.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/pulseaudio/pavucontrol.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '211e496463f621889f9c73b9646c28c8c741a0cfc96c8348c00e0560c1711d98',
     armv7l: '211e496463f621889f9c73b9646c28c8c741a0cfc96c8348c00e0560c1711d98',
     x86_64: '1a279ee44dffa2d32571e81dde1a102cd0dcd9ecc0bcfee5a02aafabca39688b'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'glibmm' => :executable
  depends_on 'glibmm_2_68' => :executable
  depends_on 'gtk4' => :executable
  depends_on 'gtkmm4' => :executable
  depends_on 'json_glib' => :executable
  depends_on 'libcanberra' => :executable
  depends_on 'libsigcplusplus' => :executable
  depends_on 'libsigcplusplus3' => :executable
  depends_on 'pulseaudio' => :executable
  depends_on 'pygtk' => :executable
end
