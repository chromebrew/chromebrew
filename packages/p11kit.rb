require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.25.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit/archive/0.25.0.tar.gz'
  source_sha256 '7bb1ec7d491fb65500e769dd90983a246b9ccc08bba89365c3e328c1a0b9ae51'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.0_armv7l/p11kit-0.25.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.0_armv7l/p11kit-0.25.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.0_i686/p11kit-0.25.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.0_x86_64/p11kit-0.25.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '141b8e69dff8cb5eab427bdbe172461f0c46245820f37de587b3fa1ab4d5d94a',
     armv7l: '141b8e69dff8cb5eab427bdbe172461f0c46245820f37de587b3fa1ab4d5d94a',
       i686: '3113c4aba59a0cbdc22f58729ddc3b5bbcd742a6686e5cf66013689127a8adf3',
     x86_64: 'cdd4857c111ac632900cb3d4dbb3b9e775b938f50bf86dccd48e6ae295e45deb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
