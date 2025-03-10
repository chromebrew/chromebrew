require 'buildsystems/autotools'

class Xrandr < Autotools
  description 'Command line interface to X11 Resize, Rotate, and Reflect (RandR) extension'
  homepage 'https://gitlab.freedesktop.org/xorg/app/xrandr'
  version '1.5.3'
  license 'Copyright © 2001 Keith Packard, member of The XFree86 Project, Inc.
Copyright © 2002 Hewlett Packard Company, Inc.
Copyright © 2006 Intel Corporation'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrandr.git'
  git_hashtag "xrandr-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '653b625434c8575fea35c39ca5e35af609211c7de54bb2544c62d5b9d835bb2c',
     armv7l: '653b625434c8575fea35c39ca5e35af609211c7de54bb2544c62d5b9d835bb2c',
     x86_64: '8ac4dfde9ec567c5ff429b4c47a3e63293e9283d304bcf447b40b7f65be3f589'
  })

  run_tests
end
