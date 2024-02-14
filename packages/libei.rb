require 'buildsystems/meson'

class Libei < Meson
  description 'library for Emulated Input'
  homepage 'https://gitlab.freedesktop.org/libinput/libei'
  version '1.2.1'
  license 'Red Hat, Inc'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libinput/libei.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6973076a5fb52d2c71fd16ec2026318d4b4b813b9e7ab38eb248f5e3888dc8c9',
     armv7l: '6973076a5fb52d2c71fd16ec2026318d4b4b813b9e7ab38eb248f5e3888dc8c9',
     x86_64: '2ab3f90cd3a8ddc7f3497471b2be3d6ab3b97431108b8d806494e3c54fe9ca49'
  })

  depends_on 'py3_attrs'
  depends_on 'py3_jinja2'
end
