require 'buildsystems/meson'

class Zathura_poppler_pdf < Meson
  description 'The zathura_poppler_pdf plugin adds PDF support to zathura by using the poppler rendering engine.'
  homepage 'https://pwmt.org/projects/zathura-pdf-poppler/'
  version '0.3.1'
  license 'BSD-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://pwmt.org/projects/zathura-pdf-poppler/download/zathura-pdf-poppler-0.3.1.tar.xz'
  source_sha256 'ee8127532cc6f92bf32d48a6a0d4c61e33cd4df49a3159e57592877ba19e108b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zathura_poppler_pdf/0.3.1_armv7l/zathura_poppler_pdf-0.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zathura_poppler_pdf/0.3.1_armv7l/zathura_poppler_pdf-0.3.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zathura_poppler_pdf/0.3.1_x86_64/zathura_poppler_pdf-0.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '30137fbf39a3c16b2225251cf93fdc85f0ee65acc6a55d0023679a796f42c17b',
     armv7l: '30137fbf39a3c16b2225251cf93fdc85f0ee65acc6a55d0023679a796f42c17b',
     x86_64: '9c81c4fbd46467d5d41af304764b7098f90403a95ce477388861dbd462b48040'
  })

  depends_on 'poppler'
end
