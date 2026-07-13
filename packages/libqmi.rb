require 'buildsystems/meson'

class Libqmi < Meson
  description 'libqmi is a glib-based library for talking to WWAN modems and devices which speak the Qualcomm MSM Interface (QMI) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libqmi/'
  version '1.38.0'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mobile-broadband/libqmi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9db4f8109ce7732da2d34d19c68e573ec583b17610e62265119138aeaa49dca2',
     armv7l: '9db4f8109ce7732da2d34d19c68e573ec583b17610e62265119138aeaa49dca2',
     x86_64: '4451de048b938be627e113be45464926fa3bcc181b0d01311e2a90192305ba46'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgudev' => :executable
  depends_on 'libmbim' => :library
  depends_on 'libqrtr_glib' => :library
end
