require 'buildsystems/meson'

class Gst_editing_services < Meson
  description 'GStreamer library for creating audio/video editors'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-editing-services.html'
  version '1.28.0'
  license 'LGPL-2.0+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://gstreamer.freedesktop.org/src/gst-editing-services/gst-editing-services-#{version}.tar.xz"
  source_sha256 'e2be873a636ca781cb1ea363867174f08c3126a55f37fc6cd8e97715aeee9c05'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5052798fc78427a79917529a280459e7ad23fd48e5843f161b2e86f0a8b03ae6',
     armv7l: '5052798fc78427a79917529a280459e7ad23fd48e5843f161b2e86f0a8b03ae6',
     x86_64: 'bded2f381b28ddbe05a115dcc48cd3c065fdf0a64aded7e77d06b0a5574405b4'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer'
  depends_on 'gir_files_rs'
  depends_on 'gtk_doc' => :build
  depends_on 'py3_pygobject' => :build

  meson_options '-Ddoc=disabled -Dvalidate=disabled'

  meson_install_extras do
    # Remove conflicts with gstreamer.
    Dir.chdir CREW_DEST_PREFIX do
      %w[bin/ges-launch-1.0
         include/gstreamer-1.0/ges/ges-asset.h
         include/gstreamer-1.0/ges/ges-audio-source.h
         include/gstreamer-1.0/ges/ges-audio-test-source.h
         include/gstreamer-1.0/ges/ges-audio-track.h
         include/gstreamer-1.0/ges/ges-audio-transition.h
         include/gstreamer-1.0/ges/ges-audio-uri-source.h
         include/gstreamer-1.0/ges/ges-base-effect-clip.h
         include/gstreamer-1.0/ges/ges-base-effect.h
         include/gstreamer-1.0/ges/ges-base-transition-clip.h
         include/gstreamer-1.0/ges/ges-base-xml-formatter.h
         include/gstreamer-1.0/ges/ges-clip-asset.h
         include/gstreamer-1.0/ges/ges-clip.h
         include/gstreamer-1.0/ges/ges-command-line-formatter.h
         include/gstreamer-1.0/ges/ges-container.h
         include/gstreamer-1.0/ges/ges-discoverer-manager.h
         include/gstreamer-1.0/ges/ges-effect-asset.h
         include/gstreamer-1.0/ges/ges-effect-clip.h
         include/gstreamer-1.0/ges/ges-effect.h
         include/gstreamer-1.0/ges/ges-enums.h
         include/gstreamer-1.0/ges/ges-extractable.h
         include/gstreamer-1.0/ges/ges-formatter.h
         include/gstreamer-1.0/ges/ges-frame-composition-meta.h
         include/gstreamer-1.0/ges/ges-gerror.h
         include/gstreamer-1.0/ges/ges-group.h
         include/gstreamer-1.0/ges/ges-image-source.h
         include/gstreamer-1.0/ges/ges-layer.h
         include/gstreamer-1.0/ges/ges-marker-list.h
         include/gstreamer-1.0/ges/ges-meta-container.h
         include/gstreamer-1.0/ges/ges-multi-file-source.h
         include/gstreamer-1.0/ges/ges-operation-clip.h
         include/gstreamer-1.0/ges/ges-operation.h
         include/gstreamer-1.0/ges/ges-overlay-clip.h
         include/gstreamer-1.0/ges/ges-pipeline.h
         include/gstreamer-1.0/ges/ges-pitivi-formatter.h
         include/gstreamer-1.0/ges/ges-prelude.h
         include/gstreamer-1.0/ges/ges-project.h
         include/gstreamer-1.0/ges/ges-screenshot.h
         include/gstreamer-1.0/ges/ges-source-clip-asset.h
         include/gstreamer-1.0/ges/ges-source-clip.h
         include/gstreamer-1.0/ges/ges-source.h
         include/gstreamer-1.0/ges/ges-test-clip.h
         include/gstreamer-1.0/ges/ges-text-overlay-clip.h
         include/gstreamer-1.0/ges/ges-text-overlay.h
         include/gstreamer-1.0/ges/ges-time-overlay-clip.h
         include/gstreamer-1.0/ges/ges-timeline-element.h
         include/gstreamer-1.0/ges/ges-timeline.h
         include/gstreamer-1.0/ges/ges-title-clip.h
         include/gstreamer-1.0/ges/ges-title-source.h
         include/gstreamer-1.0/ges/ges-track-element-asset.h
         include/gstreamer-1.0/ges/ges-track-element-deprecated.h
         include/gstreamer-1.0/ges/ges-track-element.h
         include/gstreamer-1.0/ges/ges-track.h
         include/gstreamer-1.0/ges/ges-transition-clip.h
         include/gstreamer-1.0/ges/ges-transition.h
         include/gstreamer-1.0/ges/ges-types.h
         include/gstreamer-1.0/ges/ges-uri-asset.h
         include/gstreamer-1.0/ges/ges-uri-clip.h
         include/gstreamer-1.0/ges/ges-utils.h
         include/gstreamer-1.0/ges/ges-version.h
         include/gstreamer-1.0/ges/ges-video-source.h
         include/gstreamer-1.0/ges/ges-video-test-source.h
         include/gstreamer-1.0/ges/ges-video-track.h
         include/gstreamer-1.0/ges/ges-video-transition.h
         include/gstreamer-1.0/ges/ges-video-uri-source.h
         include/gstreamer-1.0/ges/ges-xml-formatter.h
         include/gstreamer-1.0/ges/ges.h
         lib/gstreamer-1.0/libgstges.so
         lib/gstreamer-1.0/libgstnle.so
         lib/libges-1.0.so
         lib/libges-1.0.so.0
         lib/libges-1.0.so.0.2800.0
         lib/pkgconfig/gst-editing-services-1.0.pc
         lib/python3.14/site-packages/gi/overrides/GES.py
         lib/python3.14/site-packages/gi/overrides/__pycache__/GES.cpython-314.pyc
         lib64/gstreamer-1.0/libgstges.so
         lib64/gstreamer-1.0/libgstnle.so
         lib64/libges-1.0.so
         lib64/libges-1.0.so.0
         lib64/libges-1.0.so.0.2800.0
         lib64/pkgconfig/gst-editing-services-1.0.pc
         lib64/python3.14/site-packages/gi/overrides/GES.py
         lib64/python3.14/site-packages/gi/overrides/__pycache__/GES.cpython-314.pyc
         share/bash-completion/completions/ges-launch-1.0
         share/gir-1.0/GES-1.0.gir
         share/man/man1/ges-launch-1.0.1
         share/man/man1/ges-launch-1.0.1.zst].each do |f|
        FileUtils.rm_f f
      end
    end
  end
end
